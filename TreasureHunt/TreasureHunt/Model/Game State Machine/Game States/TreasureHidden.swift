//
//  TreasureHidden.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 27/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//
import GameplayKit

class TreasureHidden: GKState {
    var scene: ARGameSceneView
    
    init(scene: ARGameSceneView) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: TreasureHidden")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is AddingTrailClue.Type:
            return true
        case is AddingSignClue.Type:
            return true
        case is AddingTextClue.Type:
            return true
        default:
            return false
        }
    }
}
