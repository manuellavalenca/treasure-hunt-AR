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
    var distance: Float
    var text: String = ""
    var type: NodeType = .signClue
    var node: SCNNode = SCNNode()
    
    init(type: NodeType) {
        self.distance = 0.0
        self.text = ""
        self.type = type
        self.node = self.makeNode(as: type)
    }
    
    func makeNode(as nodeType: NodeType) -> SCNNode {
        var trailScene = SCNScene()
        var trailNode = SCNNode()
        self.node = trailNode
        switch nodeType {
        case .signClue:
            trailScene = SCNScene(named: "placaright.scn")!
            self.type = .signClue
            trailNode = trailScene.rootNode.childNodes[0]
        case .trailClue:
            trailScene = SCNScene(named: "trilhamadeira.scn")!
            self.type = .trailClue
            trailNode = trailScene.rootNode.childNodes[0]
        case .textClue:
            trailScene = SCNScene(named: "scroll.scn")!
            self.type = .textClue
            trailNode = trailScene.rootNode.childNodes[0]
        case .treasure:
            trailScene = SCNScene(named: "xis.scn")!
            trailNode = trailScene.rootNode.childNodes[0]
            self.type = .treasure
        }
        for child in trailScene.rootNode.childNodes {
            self.node.addChildNode(child)
        }
        return self.node
    }
}
