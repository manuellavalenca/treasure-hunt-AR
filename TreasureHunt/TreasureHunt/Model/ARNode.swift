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
    var distance: Float?
    var text: String?
    var type: NodeType = .treasure
    var node: SCNNode = SCNNode()
    
    init(type: NodeType) {
        var trailScene = SCNScene()
        self.type = type
        switch type {
        case .signClue:
            trailScene = SCNScene(named: "placaright.scn")!
            self.node.name = "signClue"
        case .trailClue:
            trailScene = SCNScene(named: "trilhamadeira.scn")!
            self.node.name = "trailClue"
        case .textClue:
            trailScene = SCNScene(named: "scroll.scn")!
            self.node.name = "textClue"
        case .treasure:
            trailScene = SCNScene(named: "xis.scn")!
            self.node.name = "treasure"
        }
        let trailNode = trailScene.rootNode.childNodes[0]
        for child in trailScene.rootNode.childNodes {
            trailNode.addChildNode(child)
        }
        self.node = trailNode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
