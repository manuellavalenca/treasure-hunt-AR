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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiateStateMachine()
        self.sceneView.setUpSceneView()
        self.sceneView.configureLighting()
        self.sceneView.stateMachine.enter(HidingTreasure.self)
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
        let gameNotStarted = GameNotStarted(scene: self.sceneView)
        let cameraNotAuthorized = CameraNotAuthorized(scene: self.sceneView)
        let hidingTreasure = HidingTreasure(scene: self.sceneView)
        let treasureHidden = TreasureHidden(scene: self.sceneView)
        let addingTrailClue = AddingTrailClue(scene: self.sceneView)
        let addingSignClue = AddingSignClue(scene: self.sceneView)
        let addingTextClue = AddingTextClue(scene: self.sceneView)
        let lookingForTreasure = LookingForTreasure(scene: self.sceneView)
        let treasureFound = TreasureFound(scene: self.sceneView)
        let mappingLost = MappingLost(scene: self.sceneView)
        self.sceneView.stateMachine = GKStateMachine(states: [gameNotStarted,
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
    
    @objc func changeToAddingTextClue() {
        self.sceneView.stateMachine.enter(AddingTextClue.self)
    }
    
    @objc func changeToAddingTrailClue() {
        self.sceneView.stateMachine.enter(AddingTrailClue.self)
    }
    
    @objc func changeToAddingSignClue() {
        self.sceneView.stateMachine.enter(AddingSignClue.self)
    }
    
    @objc func goToHomeScreen() {
        self.performSegue(withIdentifier: "goToHomeScreen", sender: nil)
    }
}
