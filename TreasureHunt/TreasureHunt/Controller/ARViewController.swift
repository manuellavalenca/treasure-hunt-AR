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
import AVFoundation
import GameplayKit
import NotificationCenter

class ARViewController: UIViewController {
    @IBOutlet weak var sceneView: ARGameSceneView!
    var movedForForeground = false
   var notificationCenter = NotificationCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.setUpSceneView()
        sceneView.stateMachine.enter(HidingTreasure.self)
        addTapGestureToSceneView()
        sceneView.configureLighting()
        addObservers()
    }
    
    func addObservers() {
//        notificationCenter.addObserver(self, selector: #selector(lerolero(_:)), name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.addNode(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func addNode(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let addingNode = sceneView.createNodeAR()
        guard let hitTestResult = sceneView.makeHitTestResult(with: recognizer) else { return }
        addingNode.node.transform = SCNMatrix4Mult(addingNode.node.transform, SCNMatrix4(sceneView.transformNode(in: hitTestResult)))
        addingNode.node.position = sceneView.calculatePosition(in: hitTestResult)
        sceneView.nodesArray.append(addingNode)
        sceneView.scene.rootNode.addChildNode(addingNode.node)
    }
    
    @objc func showCluesButtons() {
        print("SHOWING CLUES BUTTONS")
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
