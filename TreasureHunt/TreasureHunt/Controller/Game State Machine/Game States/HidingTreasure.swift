//
//  HidingTreasure.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//
import GameplayKit
import ARKit

class HidingTreasure: GKState {
    var scene: ARViewController
    
    init(scene: ARViewController) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: HidingTreasure")
        self.scene.addCluesTapGesture()
        self.showGamePrompt()
        self.scene.sceneView.gamePromptView?.typeLetter(text: "Bem-vindo ao Hunt. Marque o lugar em que o tesouro foi escondido tocando na tela.")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is TreasureHidden.Type:
            return true
        case is MappingLost.Type:
            return true
        default:
            return false
        }
    }
    
    func showGamePrompt() {
        self.scene.sceneView.gamePromptView = GamePrompt(frame: CGRect(x: 0, y: 0, width: 414, height: 115))
        self.scene.sceneView.addSubview(self.scene.sceneView.gamePromptView!)
        self.scene.sceneView.bringSubviewToFront(self.scene.sceneView.gamePromptView!)
    }
}
