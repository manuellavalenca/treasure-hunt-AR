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
    // MARK: - AR - Declaration
    @IBOutlet weak var sceneView: ARSCNView!
    var startingPositionNode: SCNNode?
    var endingPositionNode: SCNNode?
    let cameraRelativePosition = SCNVector3(0, 0, -0.1)
    var nodesArray: [NodeAR] = []
    var forX = false
    var movedForForeground = false
    var stateMachine: GKStateMachine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToSceneView()
        configureLighting()
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        setUpSceneView()
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    // MARK: - Detect plane in scene
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        plane.materials.first?.diffuse.contents = Colors.transparentLightGray
        let planeNode = SCNNode(geometry: plane)
        let xAxis = CGFloat(planeAnchor.center.x)
        let yAxis = CGFloat(planeAnchor.center.y)
        let zAxis = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(xAxis, yAxis, zAxis)
        planeNode.eulerAngles.x = -.pi / 2
        node.addChildNode(planeNode)
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.addNode(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == self.sceneView {
                let viewTouchLocation:CGPoint = touch.location(in: sceneView)
                guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
                    return
                }
                if stateMachine.currentState is LookingForTreasure {
                    self.checkNodes(in: result)
                }
            }
        }
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
    
    // MARK: - Touch in screen
    @objc func addNode(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let addingNode = NodeAR()
        addingNode.configureNode()
        let tapLocation = recognizer.location(in: sceneView)
        var hitTestResults = sceneView.hitTest(tapLocation, types: .featurePoint)
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let xAxis = translation.x
        let yAxis = translation.y
        let zAxis = translation.z
        let rotate = simd_float4x4(SCNMatrix4MakeRotation(sceneView.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
        let rotateTransform = simd_mul(hitTestResult.worldTransform, rotate)
        addingNode.node.transform = SCNMatrix4Mult(addingNode.node.transform, SCNMatrix4(rotateTransform))
        addingNode.node.position = SCNVector3(xAxis, yAxis, zAxis)
        self.nodesArray.append(addingNode)
        sceneView.scene.rootNode.addChildNode(addingNode.node)
        // CHANGE STATE TO TREASUREHIDDEN
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        // 3
        let xAxis = CGFloat(planeAnchor.center.x)
        let yAxis = CGFloat(planeAnchor.center.y)
        let zAxis = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(xAxis, yAxis, zAxis)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        for node in nodesArray {
            startingPositionNode = node.node
            if startingPositionNode != nil && endingPositionNode != nil {
                return
            }
            guard let xDistance = DistanceService.distance3(fromStartingPositionNode: startingPositionNode, onView: sceneView, cameraRelativePosition: cameraRelativePosition)?.x else {return}
            guard let yDistance = DistanceService.distance3(fromStartingPositionNode: startingPositionNode, onView: sceneView, cameraRelativePosition: cameraRelativePosition)?.y else {return}
            guard let zDistance = DistanceService.distance3(fromStartingPositionNode: startingPositionNode, onView: sceneView, cameraRelativePosition: cameraRelativePosition)?.z else {return}
            DispatchQueue.main.async {
                node.distance = DistanceService.distance(xAxis: xDistance, yAxis: yDistance, zAxis: zDistance)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK: - Distance
    func hideFarNodes() {
        for node in nodesArray {
            if node.distance > 3.5 {
                node.node.isHidden = true
            } else {
                node.node.isHidden = false
            }
        }
    }
}
