//
//  ARNode.swift
//  hunt
//
//  Created by Manuella Valença on 02/05/2018.
//  Copyright © 2018 Manuella Valença. All rights reserved.
//

import Foundation
import SceneKit

class NodeAR {
    private var distance: Double = 0.0
    private var text: String?
    private var type: NodeType = .treasure
    private var node: SCNNode = SCNNode()
    
    init(type: NodeType) {
        var trailScene = SCNScene()
        self.type = type
        switch type {
        case .signClue:
            trailScene = SCNScene(named: "signanimated.scn")!
        case .trailClue:
            trailScene = SCNScene(named: "trail.scn")!
        case .textClue:
            trailScene = SCNScene(named: "bottleanimated.scn")!
        case .treasure:
            trailScene = SCNScene(named: "xmark.scn")!
        }
        let trailNode = trailScene.rootNode.childNodes[0]
        for child in trailScene.rootNode.childNodes {
            trailNode.addChildNode(child)
        }
        self.node = trailNode
    }
    
    func getDistance() -> Double {
        return self.distance
    }
    
    func getText() -> String? {
        return self.text
    }
    
    func getType() -> NodeType {
        return self.type
    }
    
    func getNode() -> SCNNode {
        return self.node
    }
    
    func setDistance(to newDistance: Double) {
        self.distance = newDistance
    }
    
    func setText(text: String) {
        self.text = text
    }
    
    func setType(to newType: NodeType) {
        self.type = newType
    }
    
    func setNode(to newNode: SCNNode) {
        self.node = newNode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
