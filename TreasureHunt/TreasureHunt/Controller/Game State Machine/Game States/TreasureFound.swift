//
//  File.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import GameplayKit

class TreasureFound: GKState {
    var scene: ARViewController
    
    init(scene: ARViewController) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: TreasureFound")
        NotificationsFacade.shared.post(name: .treasureFound, object: nil)
        self.stateMachine?.enter(GameNotStarted.self)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameNotStarted.Type
    }
}
