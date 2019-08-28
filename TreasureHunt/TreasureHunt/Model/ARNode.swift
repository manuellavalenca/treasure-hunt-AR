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
        switch nodeType {
        case .signClue:
            trailScene = SCNScene(named: "placaright.scn")!
            self.type = .signClue
        case .trailClue:
            trailScene = SCNScene(named: "trilhamadeira.scn")!
            self.type = .trailClue
        case .textClue:
            trailScene = SCNScene(named: "scroll.scn")!
            self.type = .textClue
        case .treasure:
            trailScene = SCNScene(named: "xis.scn")!
            self.type = .treasure
        }
        let trailNode = trailScene.rootNode.childNodes[0]
        for child in trailScene.rootNode.childNodes {
            self.node.addChildNode(child)
        }
        self.node = trailNode
        return self.node
    }
}
