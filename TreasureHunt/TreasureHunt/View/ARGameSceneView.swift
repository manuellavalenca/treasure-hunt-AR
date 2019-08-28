//
//  GameScene.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import UIKit
import ARKit
import GameplayKit

class ARGameSceneView: ARSCNView, ARSCNViewDelegate {
    var nodesArray: [NodeAR] = []
    var stateMachine: GKStateMachine!
    var startingPositionNode: SCNNode?
    var endingPositionNode: SCNNode?
    let cameraRelativePosition = SCNVector3(0, 0, -0.1)
    
    func setUpSceneView() {
        self.initiateStateMachine()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.showsStatistics = true
        self.session.run(configuration)
        self.delegate = self
        self.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
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
        
        self.stateMachine = GKStateMachine(states: [gameNotStarted, cameraNotAuthorized, hidingTreasure,treasureHidden,addingTrailClue,addingSignClue,addingTextClue, lookingForTreasure,treasureFound,mappingLost])
    }
    
    func configureLighting() {
        self.autoenablesDefaultLighting = true
        self.automaticallyUpdatesLighting = true
    }
    
    func createNodeAR() -> NodeAR {
        var addingNode: NodeAR
        switch stateMachine.currentState {
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
            addingNode = NodeAR(type: .trailClue)
        }
        return addingNode
    }
    
    func makeHitTestResult(with recognizer: UIGestureRecognizer) -> ARHitTestResult? {
        let tapLocation = recognizer.location(in: self)
        var hitTestResults = self.hitTest(tapLocation, types: .featurePoint)
        switch stateMachine.currentState {
        case is HidingTreasure:
            hitTestResults = self.hitTest(tapLocation, types: .existingPlane)
        case is AddingTextClue:
            hitTestResults = self.hitTest(tapLocation, types: .featurePoint)
        case is AddingSignClue:
            hitTestResults = self.hitTest(tapLocation, types: .existingPlane)
        case is AddingTrailClue:
            hitTestResults = self.hitTest(tapLocation, types: .existingPlane)
        default:
            hitTestResults = self.hitTest(tapLocation, types: .featurePoint)
        }
        return hitTestResults.first
    }
    
    func calculatePosition(in hitTestResult: ARHitTestResult) -> SCNVector3 {
        let translation = hitTestResult.worldTransform.translation
        let xAxis = translation.x
        let yAxis = translation.y
        let zAxis = translation.z
        return SCNVector3(xAxis, yAxis, zAxis)
    }
    
    func transformNode(in hitTestResult: ARHitTestResult) -> simd_float4x4 {
        let rotate = simd_float4x4(SCNMatrix4MakeRotation(self.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
        return simd_mul(hitTestResult.worldTransform, rotate)
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
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
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
            guard let xDistance = DistanceService.distance3(fromStartingPositionNode: startingPositionNode, onView: self, cameraRelativePosition: cameraRelativePosition)?.x else {return}
            guard let yDistance = DistanceService.distance3(fromStartingPositionNode: startingPositionNode, onView: self, cameraRelativePosition: cameraRelativePosition)?.y else {return}
            guard let zDistance = DistanceService.distance3(fromStartingPositionNode: startingPositionNode, onView: self, cameraRelativePosition: cameraRelativePosition)?.z else {return}
            DispatchQueue.main.async {
                node.distance = DistanceService.distance(xAxis: xDistance, yAxis: yDistance, zAxis: zDistance)
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
    
    func hideFarNodes() {
        //        for node in nodesArray {
        //            if node.distance > 3.5 {
        //                node.node.isHidden = true
        //            } else {
        //                node.node.isHidden = false
        //            }
        //        }
    }
    
    func deleteNode() {
    }
}
