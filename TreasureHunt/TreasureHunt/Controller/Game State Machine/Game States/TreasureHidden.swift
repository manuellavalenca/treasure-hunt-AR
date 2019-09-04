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
        self.showCluesButtons()
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
        self.scene.cluesButtonsView = CluesButtons(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        self.scene.addSubview(self.scene.cluesButtonsView!)
        self.scene.bringSubviewToFront(self.scene.cluesButtonsView!)
        self.createEndCluesButton()
    }
    
    func createEndCluesButton() {
        self.scene.endCluesButton = ARButton(frame: CGRect(x: self.scene.cluesButtonsView!.frame.maxX + 30, y: self.scene.cluesButtonsView!.frame.midY, width: 80, height: 40))
        self.scene.endCluesButton!.setTitle("Finalizar", for: .normal)
        self.scene.endCluesButton!.addTarget(self, action: #selector(endCluesButtonTapped), for: .touchUpInside)
        self.scene.addSubview(self.scene.endCluesButton!)
    }
    
    @objc func endCluesButtonTapped() {
        self.scene.stateMachine.enter(LookingForTreasure.self)
    }
}
