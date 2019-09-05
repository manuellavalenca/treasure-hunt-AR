//
//  AddingTextClue.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 27/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import GameplayKit

class AddingTextClue: GKState {
    var scene: ARViewController
    var textClueView: TextClue?
    
    init(scene: ARViewController) {
        self.scene = scene
        super.init()
        NotificationsFacade.shared.addObserver(self, selector: #selector(showTextClueEditView), name: .textClueNodeAdded, object: nil)
        NotificationsFacade.shared.addObserver(self, selector: #selector(updateNodeText), name: .textClueTyped, object: nil)
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: AddingTextClue")
        self.scene.addCluesTapGesture()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is AddingTrailClue.Type:
            return true
        case is AddingSignClue.Type:
            return true
        case is AddingTextClue.Type:
            return true
        case is LookingForTreasure.Type:
            return true
        default:
            return false
        }
    }
    
    @objc func showTextClueEditView() {
        self.scene.removeCurrentGestureRecognizer()
        self.textClueView = TextClue(frame: CGRect(x: self.scene.sceneView.frame.midX - 220, y: self.scene.sceneView.frame.midY - 300, width: 414, height: 451))
        self.scene.sceneView.addSubview(self.textClueView!)
        self.scene.sceneView.bringSubviewToFront(self.textClueView!)
        self.textClueView?.textField.delegate = self.scene
    }
    
    @objc func updateNodeText(_ notification: Notification) {
        let text = notification.userInfo!["text"]
        //self.scene.sceneView.textFromClue = text as? String
        let nodear = self.scene.sceneView.nodesArray.last
        nodear?.setText(text: text as! String)
        print("texto do node: \(String(describing: nodear?.getText()))")
        self.removeTextClueView()
    }
    
    func removeTextClueView() {
        self.scene.stateMachine.enter(AddingTextClue.self)
    }
}
