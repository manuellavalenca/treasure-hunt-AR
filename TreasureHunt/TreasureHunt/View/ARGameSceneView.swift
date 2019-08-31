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
    var tapView: TapView?
    var cluesButtonsView: CluesButtons?
    var endCluesButton: ARButton?
    
    func addObservers() {
        NotificationsFacade.shared.addObserver(self, selector: #selector(changeToAddingTextClue), name: .addingTextClue, object: nil)
        NotificationsFacade.shared.addObserver(self, selector: #selector(changeToAddingTrailClue), name: .addingTrailClue, object: nil)
        NotificationsFacade.shared.addObserver(self, selector: #selector(changeToAddingSignClue), name: .addingSignClue, object: nil)
    }
    
    @objc func changeToAddingTextClue() {
        self.stateMachine.enter(AddingTextClue.self)
    }
    
    @objc func changeToAddingTrailClue() {
        self.stateMachine.enter(AddingTrailClue.self)
    }
    
    @objc func changeToAddingSignClue() {
        self.stateMachine.enter(AddingSignClue.self)
    }
    
    @objc func addTapView() {
        self.tapView = TapView(frame: UIScreen.main.bounds)
        self.addSubview(self.tapView!)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(manageTap(for:)))
        self.tapView!.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    @objc func manageTap(for gestureRecognizer: UIGestureRecognizer) {
        if self.stateMachine.currentState is HidingTreasure ||
            self.stateMachine.currentState is AddingTextClue ||
            self.stateMachine.currentState is AddingTrailClue ||
            self.stateMachine.currentState is AddingSignClue {
            self.addNode(withGestureRecognizer: gestureRecognizer)
        }
    }
    
    @objc func showCluesButtons() {
        self.cluesButtonsView = CluesButtons(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        self.addSubview(self.cluesButtonsView!)
        self.bringSubviewToFront(self.cluesButtonsView!)
        createEndCluesButton()
    }
    
    func createEndCluesButton() {
        endCluesButton = ARButton(frame: CGRect(x: self.cluesButtonsView!.frame.maxX + 30, y: self.cluesButtonsView!.frame.midY, width: 80, height: 40))
        endCluesButton!.setTitle("Finalizar", for: .normal)
        endCluesButton!.addTarget(self, action: #selector(endCluesButtonTapped), for: .touchUpInside)
        self.addSubview(endCluesButton!)
    }
    
    @objc func endCluesButtonTapped() {
        self.stateMachine.enter(LookingForTreasure.self)
    }
    
    func addNode(withGestureRecognizer recognizer: UIGestureRecognizer) {
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
            addingNode = NodeAR(type: .trailClue)
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
    
    func checkNodes(in result: SCNHitTestResult) {
        //
        //        sceneView.scene.enumerateChildNodes { (node: SKNode, nil) in
        //            if result == node.position {
        //                if node.name == treasure {
        //                    print("ACHOU O TESOURO")
        //                } else if node.name == text {
        //                    print("MOSTRAR TEXTO DA DICA")
        //                }
        //            }
        //        }
    }
    
    func hideFarNodes() {
        //        for node in nodesArray {
        //            if node.distance > 3.5 {
        //                node.node.isHidden = true
        //            } else {
        //                node.node.isHidden = false
        //            }
        //        }
    }
    
    func deleteNode() {
    }
}
