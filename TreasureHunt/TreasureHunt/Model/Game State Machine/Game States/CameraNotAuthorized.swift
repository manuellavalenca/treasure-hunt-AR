//
//  CameraNotAuthorized.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 27/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import GameplayKit

class CameraNotAuthorized: GKState {
    var scene: ARSceneView
    
    init(scene: ARSceneView) {
        self.scene = scene as! ARSceneView
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: CameraNotAuthorized")
    }
    
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        return stateClass is HidingTreasure.Type
//    }
    
}
