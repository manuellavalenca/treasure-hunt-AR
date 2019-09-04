//
//  ARViewController.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import GameplayKit

class ARViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var sceneView: ARGameSceneView!
    
    // Variables
    var movedForForeground = false
    var notificationCenter = NotificationCenter()
    var tapGestureRecognizer: UITapGestureRecognizer?
    var stateMachine: GKStateMachine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiateStateMachine()
        self.sceneView.setUpSceneView()
        self.sceneView.configureLighting()
        self.stateMachine.enter(HidingTreasure.self)
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func addObservers() {
        NotificationsFacade.shared.addObserver(self, selector: #selector(changeToAddingTextClue), name: .addingTextClue, object: nil)
        NotificationsFacade.shared.addObserver(self, selector: #selector(changeToAddingTrailClue), name: .addingTrailClue, object: nil)
        NotificationsFacade.shared.addObserver(self, selector: #selector(changeToAddingSignClue), name: .addingSignClue, object: nil)
        NotificationsFacade.shared.addObserver(self, selector: #selector(goToHomeScreen), name: .treasureFound, object: nil)
    }
    
    func initiateStateMachine() {
        let gameNotStarted = GameNotStarted(scene: self)
        let cameraNotAuthorized = CameraNotAuthorized(scene: self)
        let hidingTreasure = HidingTreasure(scene: self)
        let treasureHidden = TreasureHidden(scene: self)
        let addingTrailClue = AddingTrailClue(scene: self)
        let addingSignClue = AddingSignClue(scene: self)
        let addingTextClue = AddingTextClue(scene: self)
        let lookingForTreasure = LookingForTreasure(scene: self)
        let treasureFound = TreasureFound(scene: self)
        let mappingLost = MappingLost(scene: self)
        self.stateMachine = GKStateMachine(states: [gameNotStarted,
                                                    cameraNotAuthorized,
                                                    hidingTreasure,
                                                    treasureHidden,
                                                    addingTrailClue,
                                                    addingSignClue,
                                                    addingTextClue,
                                                    lookingForTreasure,
                                                    treasureFound,
                                                    mappingLost])
    }
    
    func addCluesTapGesture() {
        self.removeCurrentGestureRecognizer()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addNode(withGestureRecognizer:)))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    func addSearchTapGesture() {
        self.removeCurrentGestureRecognizer()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkNodes(with:)))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    func removeCurrentGestureRecognizer() {
        if let gesture = self.tapGestureRecognizer {
            self.sceneView.removeGestureRecognizer(gesture)
        }
    }
    
    @objc func checkNodes(with recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self.sceneView)
        let hitTestResults = self.sceneView.hitTest(tapLocation, options: nil)
        if let tappedNode = hitTestResults.first?.node {
            for nodear in self.sceneView.nodesArray {
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
        addingNode.node.transform = SCNMatrix4Mult(addingNode.node.transform, SCNMatrix4(ARService.transformNode(in: hitTestResult, target: self.sceneView)))
        addingNode.node.position = ARService.calculatePosition(in: hitTestResult)
        self.sceneView.nodesArray.append(addingNode)
        self.sceneView.scene.rootNode.addChildNode(addingNode.node)
    }
    
    func createNodeAR() -> NodeAR {
        var addingNode: NodeAR
        switch self.stateMachine.currentState {
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
        let tapLocation = recognizer.location(in: self.sceneView)
        var hitTestResults = self.sceneView.hitTest(tapLocation, types: .featurePoint)
        switch self.stateMachine.currentState {
        case is HidingTreasure:
            hitTestResults = self.sceneView.hitTest(tapLocation, types: .existingPlane)
        case is AddingTextClue:
            hitTestResults = self.sceneView.hitTest(tapLocation, types: .featurePoint)
        case is AddingSignClue:
            hitTestResults = self.sceneView.hitTest(tapLocation, types: .existingPlane)
        case is AddingTrailClue:
            hitTestResults = self.sceneView.hitTest(tapLocation, types: .existingPlane)
        default:
            hitTestResults = self.sceneView.hitTest(tapLocation, types: .featurePoint)
        }
        return hitTestResults.first
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
    
    @objc func goToHomeScreen() {
        self.performSegue(withIdentifier: "goToHomeScreen", sender: nil)
    }
}
