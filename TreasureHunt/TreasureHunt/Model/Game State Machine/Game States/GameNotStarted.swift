//
//  GameNotStarted.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 27/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//
import GameplayKit

class GameNotStarted: GKState {
    var scene: ARGameSceneView
    
    init(scene: ARGameSceneView) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: GameNotStarted")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is CameraNotAuthorized.Type:
            return true
        case is HidingTreasure.Type:
            return true
        default:
            return false
        }
    }
    
}
