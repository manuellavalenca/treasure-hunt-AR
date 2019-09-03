//
//  LookingForTreasure.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import GameplayKit
import ARKit

class LookingForTreasure: GKState {
    var scene: ARGameSceneView
    
    init(scene: ARGameSceneView) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: LookingForTreasure")
        self.removeCluesButtons()
        self.scene.addSearchTapGesture()
        self.removePlanes()
        self.scene.debugOptions = []
    }
    
    func removeCluesButtons() {
        self.scene.cluesButtonsView!.removeFromSuperview()
        self.scene.endCluesButton!.removeFromSuperview()
    }
    
    func removePlanes() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = []
        self.scene.session.run(configuration)
        self.scene.scene.rootNode.enumerateChildNodes { (node, stop) in
            if node.name == "planeNode" {
                node.isHidden = true
            }
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is TreasureFound.Type:
            return true
        case is MappingLost.Type:
            return true
        default:
            return false
        }
    }
}
