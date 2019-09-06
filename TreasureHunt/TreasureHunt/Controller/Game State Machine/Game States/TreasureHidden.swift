//
//  TreasureHidden.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 27/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//
import GameplayKit

class TreasureHidden: GKState {
    var scene: ARViewController
    
    init(scene: ARViewController) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: TreasureHidden")
        self.scene.removeCurrentGestureRecognizer()
        self.showCluesButtons()
        self.createEndCluesButton()
        self.scene.sceneView.gamePromptView?.typeLetter(text: "Vamos começar a criar o mapa. Escolha um tipo de dica e toque na tela para formar um caminho!")
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
    
    func showCluesButtons() {
        self.scene.sceneView.cluesButtonsView = CluesButtons(frame: CGRect(x: 0, y: self.scene.sceneView.frame.maxY - 500, width: 212, height: 212))
        self.scene.sceneView.addSubview(self.scene.sceneView.cluesButtonsView!)
        self.scene.sceneView.bringSubviewToFront(self.scene.sceneView.cluesButtonsView!)
    }
    
    func createEndCluesButton() {
        self.scene.sceneView.endCluesButton = ARButton(frame: CGRect(x: self.scene.sceneView.cluesButtonsView!.frame.maxX + 30, y: self.scene.sceneView.cluesButtonsView!.frame.midY, width: 80, height: 40))
        self.scene.sceneView.endCluesButton!.setTitle("Finalizar", for: .normal)
        self.scene.sceneView.endCluesButton!.addTarget(self, action: #selector(endCluesButtonTapped), for: .touchUpInside)
        self.scene.sceneView.addSubview(self.scene.sceneView.endCluesButton!)
    }
    
    @objc func endCluesButtonTapped() {
        self.scene.stateMachine.enter(LookingForTreasure.self)
    }
}
