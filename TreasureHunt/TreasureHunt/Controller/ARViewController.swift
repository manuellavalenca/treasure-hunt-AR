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
        self.sceneView.addObservers()
        self.initiateStateMachine()
        self.sceneView.setUpSceneView()
        self.sceneView.configureLighting()
        self.sceneView.stateMachine.enter(HidingTreasure.self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
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
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            if touch.view == self.sceneView {
//                let viewTouchLocation:CGPoint = touch.location(in: sceneView)
//                guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
//                    return
//                }
//                if sceneView.stateMachine.currentState is LookingForTreasure {
//                    sceneView.checkNodes(in: result)
//                }
//            }
//        }
//    }
}
