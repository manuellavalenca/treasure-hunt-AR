//
//  TextClueReading.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 05/09/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import GameplayKit
import ARKit

class TextClueReading: GKState {
    var scene: ARViewController
    var textClueReadingView: ShowTextClue?
    
    init(scene: ARViewController) {
        self.scene = scene
        super.init()
        NotificationsFacade.shared.addObserver(self, selector: #selector(removeShowTextClueView), name: .textClueRead, object: nil)
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: TextClueReading")
        self.scene.removeCurrentGestureRecognizer()
        showTextClueView()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is LookingForTreasure.Type:
            return true
        default:
            return false
        }
    }
    
    func showTextClueView() {
        self.textClueReadingView = ShowTextClue(frame: CGRect(x: self.scene.sceneView.frame.midX - 220, y: self.scene.sceneView.frame.midY - 300, width: 414, height: 451))
        updateTextClueView()
        self.scene.sceneView.addSubview(self.textClueReadingView!)
        self.scene.sceneView.bringSubviewToFront(self.textClueReadingView!)
    }
    
    func updateTextClueView() {
        let index = self.scene.sceneView.nodeTappedIndex
        let nodear = self.scene.sceneView.nodesArray[index!]
        self.textClueReadingView?.textLabel.text = nodear.getText()
    }
    
    @objc func removeShowTextClueView() {
        self.scene.stateMachine.enter(LookingForTreasure.self)
    }
}
