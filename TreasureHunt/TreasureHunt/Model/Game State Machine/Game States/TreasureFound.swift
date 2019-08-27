//
//  File.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import GameplayKit

class TreasureFound: GKState {
    var scene: ARSceneView
    
    init(scene: ARSceneView) {
        self.scene = scene as! ARSceneView
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: TreasureFound")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameNotStarted.Type
    }
    
}
