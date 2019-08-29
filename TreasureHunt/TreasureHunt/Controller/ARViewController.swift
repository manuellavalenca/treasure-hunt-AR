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
    var cluesButtonsView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.setUpSceneView()
        self.sceneView.stateMachine.enter(HidingTreasure.self)
        sceneView.configureLighting()
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func addObservers() {
        NotificationsFacade.shared.addObserver(self, selector: #selector(showCluesButtons), name: .showCluesButtons, object: nil)
        NotificationsFacade.shared.addObserver(self, selector: #selector(changeToAddingTextClue), name: .addingTextClue, object: nil)
    }
    
    @objc func showCluesButtons() {
        cluesButtonsView = Bundle.main.loadNibNamed("CluesButtons",
                                                            owner: nil,
                                                            options: nil)?.first as! UIView
        self.view.addSubview(cluesButtonsView!)
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
