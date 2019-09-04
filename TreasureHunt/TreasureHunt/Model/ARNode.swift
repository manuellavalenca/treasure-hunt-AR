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
    var distance: Double = 0.0
    var text: String?
    var type: NodeType = .treasure
    var node: SCNNode = SCNNode()
    
    init(type: NodeType) {
        var trailScene = SCNScene()
        self.type = type
        switch type {
        case .signClue:
            trailScene = SCNScene(named: "placaright.scn")!
        case .trailClue:
            trailScene = SCNScene(named: "trilhamadeira.scn")!
        case .textClue:
            trailScene = SCNScene(named: "bottleanimated.scn")!
        case .treasure:
            trailScene = SCNScene(named: "xis.scn")!
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
