//
//  GameScene.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import UIKit
import ARKit
import GameplayKit

class ARGameSceneView: ARSCNView {
    var nodesArray: [NodeAR] = []
    var startingPositionNode: SCNNode?
    var endingPositionNode: SCNNode?
    let cameraRelativePosition = SCNVector3(0, 0, -0.1)
    var stateMachine: GKStateMachine!
    var tapGestureRecognizer: UITapGestureRecognizer?
    var cluesButtonsView: CluesButtons?
    var gamePromptView: GamePrompt?
    var endCluesButton: ARButton?
    var timer: Timer!
    var counter = 0
    
    func showGamePrompt(text: String) {
        self.gamePromptView = GamePrompt(frame: CGRect(x: 0, y: 0, width: 414, height: 115))
        self.gamePromptView!.text = text
        self.addSubview(self.gamePromptView!)
        self.bringSubviewToFront(self.gamePromptView!)
        self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: false)
    }
    
    @objc func typeLetter() {
        let text = self.gamePromptView!.text
        if(self.counter < text.count) {
            let index = text.index(text.startIndex, offsetBy: self.counter)
            self.gamePromptView!.contentLabel.text! += String(text[index])
            print(text[index])
            let randomInterval = Double((arc4random_uniform(8)+1))/20
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: false)
        }
        self.counter += 1
    }
    
    func addCluesTapGesture() {
        self.removeCurrentGestureRecognizer()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addNode(withGestureRecognizer:)))
        self.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    func addSearchTapGesture() {
        self.removeCurrentGestureRecognizer()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkNodes(with:)))
        self.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    func removeCurrentGestureRecognizer() {
        if let gesture = self.tapGestureRecognizer {
            self.removeGestureRecognizer(gesture)
        }
    }
    
    @objc func checkNodes(with recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self)
        let hitTestResults = self.hitTest(tapLocation, options: nil)
        if let tappedNode = hitTestResults.first?.node {
            for nodear in self.nodesArray {
                if nodear.node.contains(tappedNode) {
                    if nodear.type == .treasure {
                        self.stateMachine.enter(TreasureFound.self)
                        print("ACHOU O TESOUROO")
                    }
                }
            }
        }
    }
    
    @objc func addNode(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let addingNode = self.createNodeAR()
        guard let hitTestResult = self.makeHitTestResult(with: recognizer) else { return }
        addingNode.node.transform = SCNMatrix4Mult(addingNode.node.transform, SCNMatrix4(ARService.transformNode(in: hitTestResult, target: self)))
        addingNode.node.position = ARService.calculatePosition(in: hitTestResult)
        self.nodesArray.append(addingNode)
        self.scene.rootNode.addChildNode(addingNode.node)
    }
    
    func createNodeAR() -> NodeAR {
        var addingNode: NodeAR
        switch stateMachine.currentState {
        case is HidingTreasure:
            addingNode = NodeAR(type: .treasure)
            self.stateMachine.enter(TreasureHidden.self)
        case is AddingTextClue:
            addingNode = NodeAR(type: .textClue)
        case is AddingSignClue:
            addingNode = NodeAR(type: .signClue)
        case is AddingTrailClue:
            addingNode = NodeAR(type: .trailClue)
        default:
            addingNode = NodeAR(type: .treasure)
        }
        return addingNode
    }
    
    func makeHitTestResult(with recognizer: UIGestureRecognizer) -> ARHitTestResult? {
        let tapLocation = recognizer.location(in: self)
        var hitTestResults = self.hitTest(tapLocation, types: .featurePoint)
        switch stateMachine.currentState {
        case is HidingTreasure:
            hitTestResults = self.hitTest(tapLocation, types: .existingPlane)
        case is AddingTextClue:
            hitTestResults = self.hitTest(tapLocation, types: .featurePoint)
        case is AddingSignClue:
            hitTestResults = self.hitTest(tapLocation, types: .existingPlane)
        case is AddingTrailClue:
            hitTestResults = self.hitTest(tapLocation, types: .existingPlane)
        default:
            hitTestResults = self.hitTest(tapLocation, types: .featurePoint)
        }
        return hitTestResults.first
    }
    
    func hideFarNodes() {
        for node in nodesArray {
            if node.distance > 3.5 {
                node.node.isHidden = true
            } else {
                node.node.isHidden = false
            }
        }
    }
    
    func deleteNode() {
        // PSIU
    }
}
