//
//  TextClueTyped.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 05/09/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import GameplayKit

class TextClueTyped: GKState {
    var scene: ARViewController
    var text: String?
    
    init(scene: ARViewController) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: TextClueTyped")
        self.removeTextClueView()
        self.updateNodeText()
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
    
    func removeTextClueView() {
        self.scene.sceneView.textClueView?.removeFromSuperview()
        self.scene.stateMachine.enter(AddingTextClue.self)
    }
    
    func updateNodeText() {
        self.scene.sceneView.nodesArray.last?.text = self.scene.sceneView.textFromClue!
    }
}
