//
//  AddingClues.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import GameplayKit

class AddingClues: GKState {
    var scene: ARSceneView
    
    init(scene: ARSceneView) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: AddingClues")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is LookingForTreasure.Type:
            return true
        case is HidingTreasure.Type:
            return true
        default:
            return false
        }
    }
    
}
