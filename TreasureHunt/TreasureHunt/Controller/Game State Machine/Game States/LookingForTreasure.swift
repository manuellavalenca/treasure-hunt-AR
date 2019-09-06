//
//  LookingForTreasure.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import GameplayKit
import ARKit

class LookingForTreasure: GKState {
    var scene: ARViewController
    
    init(scene: ARViewController) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("StateMachine: LookingForTreasure")
        self.scene.addSearchTapGesture()
        self.removePlanes()
        self.scene.sceneView.debugOptions = []
        self.removeCluesButtons()
//        createStartLookingForButton()
        self.scene.sceneView.gamePromptView?.typeLetter(text: "Passe o celular para quem vai procurar o tesouro. É hora de começar a busca!")
    }
    
    func removeCluesButtons() {
        self.scene.sceneView.cluesButtonsView!.removeFromSuperview()
        self.scene.sceneView.endCluesButton!.removeFromSuperview()
    }
    
    func removePlanes() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = []
        self.scene.sceneView.session.run(configuration)
        self.scene.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "planeNode" {
                node.isHidden = true
            }
        }
    }
    
//    func createStartLookingForButton() {
//        self.scene.sceneView.startLookingFor = ARButton(frame: CGRect(x: 50 , y: 300, width: 100, height: 50))
//        let image = UIImage(named:"Asset 3hunt")
//        self.scene.sceneView.startLookingFor?.setImage(image, for: UIControl.State.normal)
//        self.scene.sceneView.startLookingFor?.imageView?.contentMode = .scaleAspectFit
//        self.scene.sceneView.startLookingFor!.addTarget(self, action: #selector(searchStarted), for: .touchUpInside)
//        self.scene.sceneView.addSubview(self.scene.sceneView.endCluesButton!)
//    }
//
//    @objc func searchStarted() {
//        self.scene.sceneView.gamePromptView?.typeLetter(text: "Existem diferentes dicas, siga elas até encontrar o seu tesouro. Toque no ‘x’ ao encontrar o tesouro.")
//        self.scene.sceneView.startLookingFor?.removeFromSuperview()
//    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is TreasureFound.Type:
            return true
        case is MappingLost.Type:
            return true
        case is TextClueReading.Type:
            return true
        default:
            return false
        }
    }
}
