//
//  File.swift
//  hunt
//
//  Created by Manuella Valença on 29/04/2018.
//  Copyright © 2018 Manuella Valença. All rights reserved.
//

import ARKit
import SceneKit
import Foundation

extension ViewController: ARSCNViewDelegate {
    // MARK: - Detect plane in scene
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if gameRunning == false {
            // 1
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            // 2
            let width = CGFloat(planeAnchor.extent.x)
            let height = CGFloat(planeAnchor.extent.z)
            let plane = SCNPlane(width: width, height: height)
            // 3
            plane.materials.first?.diffuse.contents = UIColor.transparentLightGray
            // 4
            let planeNode = SCNNode(geometry: plane)
            // 5
            let xAxis = CGFloat(planeAnchor.center.x)
            let yAxis = CGFloat(planeAnchor.center.y)
            let zAxis = CGFloat(planeAnchor.center.z)
            planeNode.position = SCNVector3(xAxis, yAxis, zAxis)
            planeNode.eulerAngles.x = -.pi / 2
            // 6
            node.addChildNode(planeNode)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        // 3
        let xAxis = CGFloat(planeAnchor.center.x)
        let yAxis = CGFloat(planeAnchor.center.y)
        let zAxis = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(xAxis, yAxis, zAxis)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if self.gameRunning {
            self.hideFarNodes()
        }
        for node in nodesArray {
            startingPositionNode = node.node
            if startingPositionNode != nil && endingPositionNode != nil {
                return
            }
            guard let xDistance = DistanceService.distance3(fromStartingPositionNode: startingPositionNode, onView: sceneView, cameraRelativePosition: cameraRelativePosition)?.x else {return}
            guard let yDistance = DistanceService.distance3(fromStartingPositionNode: startingPositionNode, onView: sceneView, cameraRelativePosition: cameraRelativePosition)?.y else {return}
            guard let zDistance = DistanceService.distance3(fromStartingPositionNode: startingPositionNode, onView: sceneView, cameraRelativePosition: cameraRelativePosition)?.z else {return}
            DispatchQueue.main.async {
                node.distance = DistanceService.distance(xAxis: xDistance, yAxis: yDistance, zAxis: zDistance)
            }
        }
    }
}
