//
//  Service.swift
//  hunt
//
//  Created by Mila  on 02/05/2018.
//  Copyright © 2018 Manuella Valença. All rights reserved.
//

import Foundation

import UIKit
import ARKit

class DistanceService: NSObject {
    static func distance3(fromStartingPositionNode: SCNNode?, onView: ARSCNView, cameraRelativePosition: SCNVector3) -> SCNVector3? {
        guard let startingPosition = fromStartingPositionNode else { return nil }
        guard let currentFrame = onView.session.currentFrame else { return nil }
        let camera = currentFrame.camera
        let transform = camera.transform
        var translationMatrix = matrix_identity_float4x4
        translationMatrix.columns.3.x = cameraRelativePosition.x
        translationMatrix.columns.3.y = cameraRelativePosition.y
        translationMatrix.columns.3.z = cameraRelativePosition.z
        let modifiedMatrix = simd_mul(transform, translationMatrix)
        let xDistance = modifiedMatrix.columns.3.x - startingPosition.position.x
        let yDistance = modifiedMatrix.columns.3.y - startingPosition.position.y
        let zDistance = modifiedMatrix.columns.3.z - startingPosition.position.z
        return SCNVector3(xDistance, yDistance, zDistance)
    }
    
    static func distance(xAxis: Float, yAxis: Float, zAxis: Float) -> Float {
        return (sqrtf(xAxis * xAxis + yAxis * yAxis + zAxis * zAxis))
    }
}
