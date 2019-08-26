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

class ARViewController: UIViewController, ARSCNViewDelegate {
    // MARK: - AR - Declaration
    @IBOutlet weak var sceneView: ARSCNView!
    var startingPositionNode: SCNNode?
    var endingPositionNode: SCNNode?
    let cameraRelativePosition = SCNVector3(0, 0, -0.1)
    var nodesArray : [NodeAR] = []
    var forX = false
    var markTreasure = false
    var textClue = false
    var trailClue = false
    var rightClue = false
    var leftClue = false
    var gameRunning = false
    var movedForForeground = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - AR configurations
        addTapGestureToSceneView()
        configureLighting()
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        setUpSceneView()
        self.textClueTextField.delegate = self
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
        if gameRunning == false {
            // 1
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            // 2
            let width = CGFloat(planeAnchor.extent.x)
            let height = CGFloat(planeAnchor.extent.z)
            let plane = SCNPlane(width: width, height: height)
            // 3
            plane.materials.first?.diffuse.contents = UIColor.transparentLightGray
            // 4
            let planeNode = SCNNode(geometry: plane)
            // 5
            let xAxis = CGFloat(planeAnchor.center.x)
            let yAxis = CGFloat(planeAnchor.center.y)
            let zAxis = CGFloat(planeAnchor.center.z)
            planeNode.position = SCNVector3(xAxis, yAxis, zAxis)
            planeNode.eulerAngles.x = -.pi / 2
            // 6
            node.addChildNode(planeNode)
        }
    }
    
    func addTapGestureToSceneView() {
        if self.forX == false {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.addNode(withGestureRecognizer:)))
            sceneView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var index: Int = -1
        if nodesArray.isEmpty == false {
            for nodeCounter in 0 ... (nodesArray.count - 1) {
                if let touch = touches.first {
                    if touch.view == self.sceneView {
                        let viewTouchLocation:CGPoint = touch.location(in: sceneView)
                        guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
                            return
                        }
                        if nodesArray[nodeCounter].node.contains(result.node) {
                            if gameRunning == true {
                                if nodesArray[nodeCounter].isTextClue == true {
                                    textTextClueLabel.text = nodesArray[nodeCounter].text
                                    self.textTextClueView.alpha = 1
                                    autolayoutScroll(scrollView: letterView)
                                    self.view.addSubview(textTextClueView)
                                    autoLayoutView(viewAutoLayout: textTextClueView)
                                }
                                if nodesArray[nodeCounter].isTreasure == true {
                                    // ACHOU O TESOURO
                                }
                            } else {
                                if nodesArray[nodeCounter].isTreasure == false {
                                    index = nodeCounter
                                }
                            }
                        }
                    }
                }
            }
            if index != -1 {
                nodesArray[index].node.removeFromParentNode()
                nodesArray.remove(at: index)
                markTreasure = false
                textClue = false
                trailClue = false
                rightClue = false
                leftClue = false
                forX = false
                gameRunning = false
            }
        }
    }
    
    // MARK: - Touch in screen
    @objc func addNode(withGestureRecognizer recognizer: UIGestureRecognizer) {
        if gameRunning == false {
            let tapLocation = recognizer.location(in: sceneView)
            // Add node to existing plane
            var hitTestResults = sceneView.hitTest(tapLocation, types: .featurePoint)
            if markTreasure == true || textClue == true {
                hitTestResults = sceneView.hitTest(tapLocation, types: .featurePoint)
            } else {
                hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
            }
            guard let hitTestResult = hitTestResults.first else { return }
            let translation = hitTestResult.worldTransform.translation
            let xAxis = translation.x
            let yAxis = translation.y
            let zAxis = translation.z
            
            // MARK: - Geometry of each clue
            var trailScene = SCNScene()
            var trailNode = SCNNode()
            let trailARNode = NodeAR()
            if trailClue == true {
                trailScene = SCNScene(named: "trilhamadeira.scn")!
                trailARNode.isTreasure = false
                trailARNode.isTextClue = false
                trailNode = trailScene.rootNode.childNodes[0]
            } else if textClue == true {
                trailScene = SCNScene(named: "scroll.scn")!
                trailARNode.isTextClue = true
                trailARNode.isTreasure = false
                trailNode = trailScene.rootNode.childNodes[0]
                textClueTextField.placeholder = "Write your text"
                self.letterView.alpha = 1
                autolayoutScroll(scrollView: letterView)
                self.view.addSubview(letterView)
                autoLayoutView(viewAutoLayout: letterView)
            } else if rightClue == true {
                trailScene = SCNScene(named: "placaright.scn")!
                trailARNode.isTreasure = false
                trailARNode.isTextClue = false
                trailNode = trailScene.rootNode.childNodes[0]
            } else if markTreasure == true {
                forX = true
                trailScene = SCNScene(named: "xis.scn")!
                trailNode = trailScene.rootNode.childNodes[0]
                trailARNode.isTreasure = true
                trailARNode.isTextClue = false
            } else if leftClue == true {
                trailScene = SCNScene(named: "placaleft.scn")!
                trailNode = trailScene.rootNode.childNodes[0]
                trailARNode.isTreasure = false
                trailARNode.isTextClue = false
            }
            let rotate = simd_float4x4(SCNMatrix4MakeRotation(sceneView.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
            let rotateTransform = simd_mul(hitTestResult.worldTransform, rotate)
            trailNode.transform = SCNMatrix4Mult(trailNode.transform, SCNMatrix4(rotateTransform))
            trailNode.position = SCNVector3(xAxis, yAxis, zAxis)
            for child in trailScene.rootNode.childNodes {
                trailNode.addChildNode(child)
            }
            sceneView.scene.rootNode.addChildNode(trailNode)
            trailARNode.node = trailNode
            nodesArray.append(trailARNode)
            
            markTreasure = false
            textClue = false
            rightClue = false
            leftClue = false
            trailClue = false
        }
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
        if self.gameRunning {
            self.hideFarNodes()
        }
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
    
    @objc func appWillEnterForeground() {
        if  nodesArray.isEmpty == false || markTreasure == true {
            self.viewForNotification.alpha = 1
            autoLayoutView(viewAutoLayout: viewForNotification)
            self.view.addSubview(viewForNotification)
            markTreasure =  false
            textClue = false
            trailClue = false
            rightClue = false
            leftClue = false
            gameRunning = false
            movedForForeground = true
            forX = false
            forFinal = false
            treasureTipTextField.text = ""
            cluesView.isHidden = true
            markTreasureView.isHidden = true
            treasureTipView.isHidden = true
        } else if forFinal == true {
            viewForNotification.removeFromSuperview()
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
