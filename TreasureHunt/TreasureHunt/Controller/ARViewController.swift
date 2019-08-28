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

class ARViewController: UIViewController {
    @IBOutlet weak var sceneView: ARGameSceneView!
    var movedForForeground = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.setUpSceneView()
        sceneView.stateMachine.enter(HidingTreasure.self)
        addTapGestureToSceneView()
        sceneView.configureLighting()
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
        print("addingNode é \(addingNode.type)")
        guard let hitTestResult = sceneView.makeHitTestResult(with: recognizer) else { return }
        addingNode.node.transform = SCNMatrix4Mult(addingNode.node.transform, SCNMatrix4(sceneView.transformNode(in: hitTestResult)))
        addingNode.node.position = sceneView.calculatePosition(in: hitTestResult)
        sceneView.nodesArray.append(addingNode)
        print("Node pra adicionar: \(addingNode.node.name!)")
        sceneView.scene.rootNode.addChildNode(addingNode.node)
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
