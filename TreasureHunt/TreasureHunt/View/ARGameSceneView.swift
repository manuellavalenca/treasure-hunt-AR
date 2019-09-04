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

class ARGameSceneView: ARSCNView {
    var nodesArray: [NodeAR] = []
    var startingPositionNode: SCNNode?
    var endingPositionNode: SCNNode?
    let cameraRelativePosition = SCNVector3(0, 0, -0.1)
    var cluesButtonsView: CluesButtons?
    var gamePromptView: GamePrompt?
    var endCluesButton: ARButton?
    
    func hideFarNodes() {
        for node in nodesArray {
            if node.distance > 3.5 {
                node.node.isHidden = true
            } else {
                node.node.isHidden = false
            }
        }
    }
    
    func deleteNode() {
        // PSIU
    }
}

extension ARGameSceneView: ARSCNViewDelegate {
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.showsStatistics = true
        self.session.run(configuration)
        self.delegate = self
        self.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    func configureLighting() {
        self.autoenablesDefaultLighting = true
        self.automaticallyUpdatesLighting = true
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        plane.materials.first?.diffuse.contents = Constants.Colors.transparentLightGray
        let planeNode = SCNNode(geometry: plane)
        let xAxis = CGFloat(planeAnchor.center.x)
        let yAxis = CGFloat(planeAnchor.center.y)
        let zAxis = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(xAxis, yAxis, zAxis)
        planeNode.eulerAngles.x = -.pi / 2
        planeNode.name = "planeNode"
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
            guard let xDistance = ARService.distance3(fromStartingPositionNode: startingPositionNode, onView: self, cameraRelativePosition: cameraRelativePosition)?.x else {return}
            guard let yDistance = ARService.distance3(fromStartingPositionNode: startingPositionNode, onView: self, cameraRelativePosition: cameraRelativePosition)?.y else {return}
            guard let zDistance = ARService.distance3(fromStartingPositionNode: startingPositionNode, onView: self, cameraRelativePosition: cameraRelativePosition)?.z else {return}
            DispatchQueue.main.async {
                node.distance = Double(ARService.distance(xAxis: xDistance, yAxis: yDistance, zAxis: zDistance))
            }
        }
        self.hideFarNodes()
    }
}

