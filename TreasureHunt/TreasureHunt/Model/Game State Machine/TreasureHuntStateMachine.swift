//
//  StateMachine.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import UIKit
import GameplayKit.GKStateMachine

class TreasureHuntStateMachine: GKStateMachine {
    let presenter: UINavigationController
    
    init(presenter: UINavigationController,
         states: [GKState]) {
        // 1
        self.presenter = presenter
        
        // 2
        self.kanjiStorage = kanjiStorage
        
        // 3
        super.init(states: states)
    }
}
