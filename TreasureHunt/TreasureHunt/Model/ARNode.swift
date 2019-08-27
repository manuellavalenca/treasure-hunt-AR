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
    var distance: Float = 0.0
    var text: String = ""
    var type: nodeType = .signClue
    var node: SCNNode = SCNNode()
    
    func configureNode() -> NodeAR {
        var trailScene = SCNScene()
        var trailNode = SCNNode()
        self.node = trailNode
        switch GameState {
        case AddingSignClue:
            trailScene = SCNScene(named: "placaright.scn")!
            self.type = .signClue
            trailNode = trailScene.rootNode.childNodes[0]
        case AddingTrailClue:
            trailScene = SCNScene(named: "trilhamadeira.scn")!
            self.type = .trailClue
            trailNode = trailScene.rootNode.childNodes[0]
        case AddingTextClue:
            trailScene = SCNScene(named: "scroll.scn")!
            self.type = .textClue
            trailNode = trailScene.rootNode.childNodes[0]
        case HidingTreasure:
            trailScene = SCNScene(named: "xis.scn")!
            trailNode = trailScene.rootNode.childNodes[0]
            self.type = .treasure
        }
        for child in trailScene.rootNode.childNodes {
            self.node.addChildNode(child)
        }
        return self
    }
}

enum nodeType {
    case treasure
    case textClue
    case signClue
    case trailClue
}
