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
    var cluesButtonsView: CluesButtons?
    var tapView: TapView?
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        sceneView.setUpSceneView()
        self.sceneView.stateMachine.enter(HidingTreasure.self)
        sceneView.configureLighting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func addObservers() {
        NotificationsFacade.shared.addObserver(self, selector: #selector(addTapView), name: .hidingTreasure, object: nil)
        NotificationsFacade.shared.addObserver(self, selector: #selector(showCluesButtons), name: .treasureHidden, object: nil)
        NotificationsFacade.shared.addObserver(self, selector: #selector(changeToAddingTextClue), name: .addingTextClue, object: nil)
    }
    
    @objc func addTapView() {
        self.tapView = TapView(frame: UIScreen.main.bounds)
        self.sceneView.addSubview(self.tapView!)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(manageTap(for:)))
        self.tapView!.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    @objc func manageTap(for gestureRecognizer: UIGestureRecognizer) {
        if self.sceneView.stateMachine.currentState is HidingTreasure ||
            self.sceneView.stateMachine.currentState is AddingTextClue ||
            self.sceneView.stateMachine.currentState is AddingTrailClue ||
            self.sceneView.stateMachine.currentState is AddingSignClue {
            self.sceneView.addNode(withGestureRecognizer: gestureRecognizer)
        }
    }
    
    @objc func showCluesButtons() {
        //self.tapView!.removeGestureRecognizer(self.tapGestureRecognizer!)
        self.cluesButtonsView = CluesButtons(frame: CGRect(x: 100, y: 100, width: 250, height: 250))
        self.sceneView.addSubview(self.cluesButtonsView!)
        self.sceneView.bringSubviewToFront(self.cluesButtonsView!)
    }
    
    @objc func changeToAddingTextClue() {
        self.sceneView.stateMachine.enter(AddingTextClue.self)
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
