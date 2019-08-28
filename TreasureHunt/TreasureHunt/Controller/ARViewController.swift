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

class ARViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet weak var sceneView: ARGameSceneView!
    var movedForForeground = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToSceneView()
        sceneView.configureLighting()
        sceneView.setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARGameSceneView.addNode(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == self.sceneView {
                let viewTouchLocation:CGPoint = touch.location(in: sceneView)
                guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
                    return
                }
                if sceneView.stateMachine.currentState is LookingForTreasure {
                    sceneView.checkNodes(in: result)
                }
            }
        }
    }
}
