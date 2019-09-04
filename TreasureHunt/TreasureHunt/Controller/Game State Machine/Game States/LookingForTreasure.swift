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
    var scene: ARViewController
    
    init(scene: ARViewController) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: LookingForTreasure")
        self.removeCluesButtons()
        self.scene.addSearchTapGesture()
        self.removePlanes()
        self.scene.sceneView.debugOptions = []
        self.scene.sceneView.gamePromptView?.typeLetter(text: "Passe o celular para quem vai procurar o tesouro. Vamos começar a busca!")
    }
    
    func removeCluesButtons() {
        self.scene.sceneView.cluesButtonsView!.removeFromSuperview()
        self.scene.sceneView.endCluesButton!.removeFromSuperview()
    }
    
    func removePlanes() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = []
        self.scene.sceneView.session.run(configuration)
        self.scene.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
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
