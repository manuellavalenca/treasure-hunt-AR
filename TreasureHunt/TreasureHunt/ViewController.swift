//
//  ViewController.swift
//  hunt
//
//  Created by Manuella Valença on 28/04/2018.
//  Copyright © 2018 Manuella Valença. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    var markTreasure = false
    var textClue = false
    var trailClue = false
    var rightClue = false
    var leftClue = false
    var gameRunning = false
    var movedForForeground = false
    var forX = false
    var forFinal = false
    var musicPlaying = false
    
    //MARK: Subviews
    
    @IBOutlet var introScreen: UIView!
    @IBOutlet var welcomeScreen: UIView!
    @IBOutlet var step1: UIView!
    @IBOutlet var markTreasureView: UIView!
    @IBOutlet var markPupUpView: UIView!
    @IBOutlet weak var imageDetection: UIImageView!
    @IBOutlet var imageDetectionView: UIView!
    @IBOutlet var step2View: UIView!
    @IBOutlet var cluesView: UIView!
    @IBOutlet var chooseHintPopUp: UIView!
    @IBOutlet var touchScreenPopUp: UIView!
    @IBOutlet var changeCharacterView: UIView!
    @IBOutlet var seekView: UIView!
    @IBOutlet var treasureTipView: UIView!
    @IBOutlet var foundTreasureView: UIView!
    @IBOutlet var viewForNotification: UIView!
    
    //MARK: Label das dicas
    
    @IBOutlet weak var trilha: UILabel!
    @IBOutlet weak var esquerda: UILabel!
    @IBOutlet weak var direita: UILabel!
    @IBOutlet weak var text: UILabel!
    
    // MARK: - AR - Declaration
    @IBOutlet weak var sceneView: ARSCNView!
    var startingPositionNode: SCNNode?
    var endingPositionNode: SCNNode?
    let cameraRelativePosition = SCNVector3(0,0,-0.1)
    var nodesArray : [NodeAR] = []
    
    // MARK: - Introduction - Declaration
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var trailImage: UIImageView!
    var backgroundMusic = AVAudioPlayer()
    @IBOutlet weak var seloButton: UIButton!
    @IBOutlet weak var storyScreenImage: UIImageView!
    @IBOutlet weak var som: UIButton!
    
    // MARK: - Bilhete
    @IBOutlet weak var letterView: UIView!
    
    // MARK: - Hide - Declaration
    
    @IBOutlet weak var hideCharacterBackground: UIView!
    
    @IBOutlet weak var treasureChoosedButton: UIButton!
    
    @IBOutlet weak var treasureLocationImage: UIImageView!
    
    @IBOutlet weak var backStep1: UIButton!
    
    @IBOutlet weak var trail3Image: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var
    remarkTreasureLocationButton: UIButton!
    @IBOutlet weak var markTreasureLocationButton: UIButton!
    
    @IBOutlet weak var treasureTipTextField: UITextField!
    @IBOutlet weak var markXImage: UIImageView!
    
    
    // MARK: - Clues - Declaration
    @IBOutlet weak var clueLabelView: UIImageView!
    
    @IBOutlet weak var addClueButton: UIButton!
    
    @IBOutlet weak var clueInfoLabelView: UIImageView!
    
    //    @IBOutlet weak var cluesStylesView: UIView!
    
    @IBOutlet weak var trailClueButton: UIButton!
    @IBOutlet weak var textClueButton: UIButton!
    @IBOutlet weak var rightClueButton: UIButton!
    @IBOutlet weak var leftClueButton: UIButton!
    
    @IBOutlet weak var textClueTextField: UITextField!
    @IBOutlet weak var textWrittenButton: UIButton!
    @IBOutlet weak var textTextClueView: UIView!
    @IBOutlet weak var textTextClueLabel: UILabel!
    @IBOutlet weak var okTextClueTextButton: UIButton!
    
    @IBOutlet weak var viewFinal: UIImageView!
    
    
    @IBOutlet weak var buttonFinal: UIButton!
    @IBOutlet weak var clueFinishedButton: UIButton!
    
    // MARK: - Seek - Declaration
    @IBOutlet weak var seekCharacterView: UIImageView!
    
    @IBOutlet weak var startHuntButton: UIButton!
    @IBOutlet weak var treasureTipLabel: UILabel!
    
    // MARK: - For Nofitication
    
    @IBOutlet weak var imageViewForNotification: UIImageView!
    @IBOutlet weak var buttonForNotification: UIButton!
    
    @IBAction func finalButton(_ sender: Any) {
        
        markTreasure = false
        textClue = false
        trailClue = false
        rightClue = false
        leftClue = false
        gameRunning = false
        forX = false
        forFinal = false
        treasureTipTextField.text = ""
        
        self.welcomeScreen.removeFromSuperview()
        self.step1.removeFromSuperview()
        self.markPupUpView.removeFromSuperview()
        self.imageDetectionView.removeFromSuperview()
        markTreasureView.isHidden = true
        self.step2View.removeFromSuperview()
        self.chooseHintPopUp.removeFromSuperview()
        self.touchScreenPopUp.removeFromSuperview()
        self.changeCharacterView.removeFromSuperview()
        self.letterView.removeFromSuperview()
        self.textTextClueView.removeFromSuperview()
        self.seekView.removeFromSuperview()
        self.treasureTipView.isHidden = true
        self.foundTreasureView.removeFromSuperview()
        
        self.introScreen.alpha = 1
        self.view.addSubview(introScreen)
        autoLayoutView(viewAutoLayout: introScreen)
        
        
        sceneView.isHidden = true
        
        self.view.bringSubviewToFront(introScreen)
        
        self.introScreen.alpha = 1
        
        //        UIView.animate(withDuration: 2) {
        //            self.IntroScreen.alpha = 1
        //            //self.IntroScreen.transform = CGAffineTransform (scaleX: 1, y: 1)
        //        }
        
        forX = false
        
        for node in nodesArray {
            node.node.removeFromParentNode()
            nodesArray = []
        }
        
        
    }
    
    // MARK: - Game order
    
    @IBAction func showStory(_ sender: Any) {
        
        self.welcomeScreen.alpha = 1
        self.view.addSubview(welcomeScreen)
        autoLayoutView(viewAutoLayout: welcomeScreen)
        
        
        self.introScreen.alpha = 1
        self.view.bringSubviewToFront(introScreen)
        
        UIView.animate(withDuration: 0.3){
            self.introScreen.alpha = 0
        }
        
        self.introScreen.removeFromSuperview()
    }
    
    @IBAction func startGame(_ sender: Any) {
        //        self.IntroScreen.removeFromSuperview()
        
        self.step1.alpha = 1
        self.view.addSubview(step1)
        autoLayoutView(viewAutoLayout: step1)
        self.view.bringSubviewToFront(welcomeScreen)
        
        UIView.animate(withDuration: 0.3){
            self.welcomeScreen.alpha = 0
        }
        
        self.welcomeScreen.removeFromSuperview()
        
    }
    
    @IBAction func markTreasureLocation(_ sender: Any) {
        
        if treasureTipTextField.text != nil {
            treasureTipLabel.text = "Treasure's tip: " + treasureTipTextField.text!
        }
        
        sceneView.isHidden = false
        self.markTreasureView.alpha = 1
        
        markTreasureView.isHidden = false
        
        self.view.bringSubviewToFront(step1)
        
        UIView.animate(withDuration: 0.3){
            self.step1.alpha = 0
        }
        
        self.step1.removeFromSuperview()
        
        showImageDetection()
        
        markTreasure = true
        
    }
    
    @IBAction func treasureLocationMarked(_ sender: Any) {
        markTreasure = false
        //        self.step1.removeFromSuperview()
        self.step2View.alpha = 1
        self.view.addSubview(step2View)
        autoLayoutView(viewAutoLayout: step2View)
        
        markTreasureView.isHidden = true
        
        markPupUpView.isHidden = true
        imageDetectionView.isHidden = true
    }
    
    @IBAction func addClues(_ sender: Any) {
        markTreasure = false
        textClue = false
        trailClue = false
        rightClue = false
        leftClue = false
        gameRunning = false
        
        //        self.markTreasureView.removeFromSuperview()
        //        self.imageDetectionView.removeFromSuperview()
        //        self.markPupUpView.removeFromSuperview()
        
        
        self.cluesView.isHidden = false
        self.cluesView.alpha = 1
        
        cluesPopupsAnimation()
        self.view.bringSubviewToFront(step2View)
        
        
        UIView.animate(withDuration: 0.3){
            self.step2View.alpha = 0
        }
        
        self.step2View.removeFromSuperview()
        
    }
    
    @IBAction func trailCluePressed(_ sender: Any) {
        markTreasure = false
        textClue = false
        trailClue = true
        rightClue = false
        leftClue = false
        
    }
    
    @IBAction func textCluePressed(_ sender: Any) {
        markTreasure = false
        textClue = true
        trailClue = false
        rightClue = false
        leftClue = false
        
        
        textClueTextField.text = ""
    }
    
    @IBAction func textClueDone(_ sender: Any) {
        
        letterView.removeFromSuperview()
        
        let last = nodesArray.count - 1
        
        if textClueTextField.text != nil {
            nodesArray[last].text =  textClueTextField.text!
        }
        
        textTextClueLabel.text = ""
    }
    
    @IBAction func readTextClue(_ sender: Any) {
        textTextClueView.removeFromSuperview()
    }
    
    @IBAction func rightCluePressed(_ sender: Any) {
        markTreasure = false
        textClue = false
        trailClue = false
        rightClue = true
        leftClue = false
    }
    
    @IBAction func leftCluePressed(_ sender: Any) {
        markTreasure = false
        textClue = false
        trailClue = false
        rightClue = false
        leftClue = true
    }
    
    
    
    @IBAction func finishClue(_ sender: Any) {
        trailClue = false
        textClue = false
        
        self.view.addSubview(changeCharacterView)
        autoLayoutView(viewAutoLayout: changeCharacterView)
        self.changeCharacterView.alpha = 1
        
        cluesPopupsAnimation()
        
        self.cluesView.isHidden = false
        
        //        touchScreenPopUp.isHidden = true
        //        chooseHintPopUp.isHidden = true
    }
    
    @IBAction func startHunt(_ sender: Any){
        
        gameRunning = true
        self.cluesView.isHidden = true
        
        if treasureTipTextField.text == ""{
            self.treasureTipView.isHidden = true
        } else{
            self.treasureTipView.alpha = 1
            self.treasureTipView.isHidden = false
        }
        
        self.view.bringSubviewToFront(changeCharacterView)
        
        UIView.animate(withDuration: 0.3) {
            self.changeCharacterView.alpha = 0
        }
        
        self.changeCharacterView.removeFromSuperview()
        
        self.seekView.alpha = 1
        autoLayoutPopups(popup: seekView)
        self.view.addSubview(seekView)
        
        seekInfoAnimation()
        
    }
    
    @IBAction func returnScreen(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3){
            self.introScreen.alpha = 1
            self.introScreen.center = CGPoint(x: 160, y: 284)
        }
        
        self.introScreen.alpha = 1
        self.view.addSubview(introScreen)
        autoLayoutView(viewAutoLayout: introScreen)
        
    }
    
    @IBAction func returnStep1(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3){
            self.welcomeScreen.alpha = 1
            self.welcomeScreen.center = CGPoint(x: 160, y: 284)
        }
        self.welcomeScreen.alpha = 1
        
        self.view.addSubview(welcomeScreen)
        autoLayoutView(viewAutoLayout: welcomeScreen)
    }
    
    
    @IBAction func changeTreasureLocation(_ sender: Any) {
        // excluir o ultimo node adicionado
        let ultimo = nodesArray.count - 1
        if nodesArray.count > 0 {
            nodesArray[ultimo].node.removeFromParentNode()
            markTreasure = true
        }
        
    }
    
    
    @IBAction func playMusicButton(_ sender: Any) {
        if musicPlaying == true{
            backgroundMusic.pause()
            som.setImage(UIImage(named: "speaker-2.png"), for: .normal)
            musicPlaying = false
        } else{
            backgroundMusic.play()
            som.setImage(UIImage(named: "speaker.png"), for: .normal)
            musicPlaying = true
        }
        
        
    }
    
    //MARK: - Pop ups animations
    
    func showImageDetection() {
        
        self.imageDetectionView.alpha = 1
        self.markPupUpView.alpha = 1
        
        self.view.bringSubviewToFront(imageDetectionView)
        self.view.bringSubviewToFront(markPupUpView)
        
        if movedForForeground == false {
            imageDetectionView.center.y -= imageDetectionView.frame.height
            markPupUpView.center.y -= markPupUpView.frame.height
        }
        
        autoLayoutPopups(popup: imageDetectionView)
        self.view.addSubview(imageDetectionView)
        
        autoLayoutPopups(popup: markPupUpView)
        self.view.addSubview(markPupUpView)
        
        UIView.animate(withDuration: 1, delay: 0.3, options: [], animations: {
            self.imageDetectionView.center.y += self.imageDetectionView.frame.height
        }, completion: {(value:Bool) in
            UIView.animate(withDuration: 1, delay: 2, options: [], animations: {
                self.imageDetectionView.center.y -= self.imageDetectionView.frame.height
            }, completion: {(value:Bool) in
                UIView.animate(withDuration: 1, delay: 0.3, options: [], animations: {
                    self.markPupUpView.center.y += self.markPupUpView.frame.height
                }, completion: {(value:Bool) in
                    UIView.animate(withDuration: 1, delay: 3, options: [], animations: {
                        self.markPupUpView.center.y -= self.markPupUpView.frame.height
                    }, completion: nil)
                })
            })
        })
        
    }
    
    func cluesPopupsAnimation() {
        
        self.touchScreenPopUp.alpha = 1
        self.chooseHintPopUp.alpha = 1
        
        self.view.bringSubviewToFront(touchScreenPopUp)
        self.view.bringSubviewToFront(chooseHintPopUp)
        
        if movedForForeground == false{
            chooseHintPopUp.center.y -= chooseHintPopUp.frame.height
            touchScreenPopUp.center.y -= touchScreenPopUp.frame.height
        } else {
            chooseHintPopUp.center.y -= chooseHintPopUp.frame.height
            touchScreenPopUp.center.y -= touchScreenPopUp.frame.height
            
        }
        
        autoLayoutPopups(popup: chooseHintPopUp)
        self.view.addSubview(chooseHintPopUp)
        autoLayoutPopups(popup: touchScreenPopUp)
        self.view.addSubview(touchScreenPopUp)
        
        UIView.animate(withDuration: 1, delay: 0.3, options: [], animations: {
            self.chooseHintPopUp.center.y += self.chooseHintPopUp.frame.height
        }, completion: {(value:Bool) in
            UIView.animate(withDuration: 1, delay: 2, options: [], animations: {
                self.chooseHintPopUp.center.y -= self.chooseHintPopUp.frame.height
            }, completion: {(value:Bool) in
                UIView.animate(withDuration: 1, delay: 0.3, options: [], animations: {
                    self.touchScreenPopUp.center.y += self.touchScreenPopUp.frame.height
                }, completion: {(value:Bool) in
                    UIView.animate(withDuration: 1, delay: 3, options: [], animations: {
                        self.touchScreenPopUp.center.y -= self.touchScreenPopUp.frame.height
                    }, completion: nil)
                })
            })
        })
        
    }
    
    func seekInfoAnimation() {
        self.view.bringSubviewToFront(seekView)
        
        seekView.center.y -= seekView.frame.height
        
        self.seekView.alpha = 1
        autoLayoutPopups(popup: seekView)
        self.view.addSubview(seekView)
        
        UIView.animate(withDuration: 1, delay: 0.3, options: [], animations: {
            self.seekView.center.y += self.seekView.frame.height
        }, completion: {(value:Bool) in
            UIView.animate(withDuration: 1, delay: 3, options: [], animations: {
                self.seekView.center.y -= self.seekView.frame.height
            }, completion: nil)
        })
    }
    
    
    //MARK: - When the user moved the app to background
    
    @IBAction func closedNotification(_ sender: Any) {
        
        self.welcomeScreen.removeFromSuperview()
        self.step1.removeFromSuperview()
        self.markPupUpView.removeFromSuperview()
        self.imageDetectionView.removeFromSuperview()
        markTreasureView.isHidden = true
        self.step2View.removeFromSuperview()
        self.chooseHintPopUp.removeFromSuperview()
        self.touchScreenPopUp.removeFromSuperview()
        self.changeCharacterView.removeFromSuperview()
        self.letterView.removeFromSuperview()
        self.textTextClueView.removeFromSuperview()
        self.seekView.removeFromSuperview()
        self.treasureTipView.isHidden = true
        self.foundTreasureView.removeFromSuperview()
        
        self.introScreen.alpha = 1
        
        self.view.addSubview(introScreen)
        autoLayoutView(viewAutoLayout: introScreen)
        
        sceneView.isHidden = true
        
        self.view.bringSubviewToFront(introScreen)
        
        self.introScreen.alpha = 1
        
        self.viewForNotification.removeFromSuperview()
        
        //        UIView.animate(withDuration: 2) {
        //            self.IntroScreen.alpha = 1
        //            //self.IntroScreen.transform = CGAffineTransform (scaleX: 1, y: 1)
        //        }
        
        forX = false
        
        for node in nodesArray {
            node.node.removeFromParentNode()
            nodesArray = []
        }
        
    }
    
    @objc func appWillEnterForeground() {
        
        //        markTreasure =  false
        //        textClue = false
        //        trailClue = false
        //        rightClue = false
        //        leftClue = false
        //        gameRunning = false
        //        movedForForeground = true
        //        forX = false
        //        forFinal = false
        //        treasureTipTextField.text = ""
        
        if  nodesArray.count > 0 || markTreasure == true {
            
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
            
        }
        else if forFinal == true {
            viewForNotification.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - First screen appears
        self.cluesView.isHidden = true
        markTreasureView.isHidden = true
        self.introScreen.alpha = 1
        self.view.addSubview(introScreen)
        autoLayoutView(viewAutoLayout: introScreen)
        self.treasureTipView.isHidden = true
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        // MARK: - Background Music by: bensound.com
        
        let url = Bundle.main.url(forResource: "bensound-sunny", withExtension: ".mp3")
        
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: url!)
            backgroundMusic.prepareToPlay()
            backgroundMusic.play()
            musicPlaying = true
        } catch let error as NSError{
            print(error.debugDescription)
        }
        
        // MARK: - AR configurations
        addTapGestureToSceneView()
        configureLighting()
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        
        setUpSceneView()
        
        self.treasureTipTextField.delegate = self
        self.textClueTextField.delegate = self
    }
    
    //MARK : - Auto Layout
    
    func autoLayoutView(viewAutoLayout : UIView) {
        
        viewAutoLayout.frame = self.view.bounds
        viewAutoLayout.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func autoLayoutPopups(popup: UIView){
        popup.center.x = self.view.center.x
    }
    
    func autolayoutScroll(scrollView: UIView){
        scrollView.center = self.view.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // MARK: - Distance
    
    func compararDistancia( ) {
        for node in nodesArray {
            if node.distance > 3.5 {
                node.node.isHidden = true
            } else{
                node.node.isHidden = false
            }
        }
    }
    
    // MARK: - Touch in screen
    
    @objc func addNode(withGestureRecognizer recognizer: UIGestureRecognizer) {
        
        if gameRunning == false{
            
            let tapLocation = recognizer.location(in: sceneView)
            
            // Add node to existing plane
            
            var hitTestResults = sceneView.hitTest(tapLocation, types: .featurePoint)
            
            if markTreasure == true{
                hitTestResults = sceneView.hitTest(tapLocation, types: .featurePoint)
            } else if textClue == true{
                hitTestResults = sceneView.hitTest(tapLocation, types: .featurePoint)
            } else if trailClue == true{
                hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
            } else if rightClue == true{
                hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
            } else if leftClue == true{
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
            var trailARNode = NodeAR()
            
            if trailClue == true{
                trailScene = SCNScene(named: "trilhamadeira.scn")!
                trailNode = trailScene.rootNode.childNodes[0]
                
                let rotate = simd_float4x4(SCNMatrix4MakeRotation(sceneView.session.currentFrame!.camera.eulerAngles.y,0,1,0))
                let rotateTransform = simd_mul(hitTestResult.worldTransform, rotate)
                trailNode.transform = SCNMatrix4Mult(trailNode.transform, SCNMatrix4(rotateTransform))
                
                trailNode.position = SCNVector3(xAxis, yAxis, zAxis)
                for child in trailScene.rootNode.childNodes {
                    trailNode.addChildNode(child)
                }
                sceneView.scene.rootNode.addChildNode(trailNode)
                
                trailARNode.isTreasure = false
                trailARNode.isTextClue = false
                trailARNode.node = trailNode
                nodesArray.append(trailARNode)
                
            } else if textClue == true {
                trailScene = SCNScene(named: "scroll.scn")!
                trailNode = trailScene.rootNode.childNodes[0]
                
                let rotate = simd_float4x4(SCNMatrix4MakeRotation(sceneView.session.currentFrame!.camera.eulerAngles.y,0,1,0))
                let rotateTransform = simd_mul(hitTestResult.worldTransform, rotate)
                trailNode.transform = SCNMatrix4Mult(trailNode.transform, SCNMatrix4(rotateTransform))
                
                trailNode.position = SCNVector3(xAxis, yAxis, zAxis)
                for child in trailScene.rootNode.childNodes {
                    trailNode.addChildNode(child)
                }
                sceneView.scene.rootNode.addChildNode(trailNode)
                
                trailARNode.isTextClue = true
                trailARNode.isTreasure = false
                trailARNode.node = trailNode
                nodesArray.append(trailARNode)
                
                textClueTextField.placeholder = "Write your text"
                self.letterView.alpha = 1
                
                autolayoutScroll(scrollView: letterView)
                self.view.addSubview(letterView)
                autoLayoutView(viewAutoLayout: letterView)
                
            } else if rightClue == true{
                trailScene = SCNScene(named: "placaright.scn")!
                trailNode = trailScene.rootNode.childNodes[0]
                
                let rotate = simd_float4x4(SCNMatrix4MakeRotation(sceneView.session.currentFrame!.camera.eulerAngles.y,0,1,0))
                let rotateTransform = simd_mul(hitTestResult.worldTransform, rotate)
                trailNode.transform = SCNMatrix4Mult(trailNode.transform, SCNMatrix4(rotateTransform))
                
                trailNode.position = SCNVector3(xAxis, yAxis, zAxis)
                
                for child in trailScene.rootNode.childNodes {
                    trailNode.addChildNode(child)
                }
                sceneView.scene.rootNode.addChildNode(trailNode)
                
                trailARNode.isTreasure = false
                trailARNode.isTextClue = false
                trailARNode.node = trailNode
                nodesArray.append(trailARNode)
                
            } else if markTreasure == true{
                forX = true
                trailScene = SCNScene(named: "xis.scn")!
                trailNode = trailScene.rootNode.childNodes[0]
                trailNode.position = SCNVector3(xAxis, yAxis, zAxis)
                for child in trailScene.rootNode.childNodes {
                    trailNode.addChildNode(child)
                }
                sceneView.scene.rootNode.addChildNode(trailNode)
                
                trailARNode.isTreasure = true
                trailARNode.isTextClue = false
                trailARNode.node = trailNode
                nodesArray.append(trailARNode)
                
            } else if leftClue == true{
                trailScene = SCNScene(named: "placaleft.scn")!
                trailNode = trailScene.rootNode.childNodes[0]
                
                let rotate = simd_float4x4(SCNMatrix4MakeRotation(sceneView.session.currentFrame!.camera.eulerAngles.y,0,1,0))
                let rotateTransform = simd_mul(hitTestResult.worldTransform, rotate)
                trailNode.transform = SCNMatrix4Mult(trailNode.transform, SCNMatrix4(rotateTransform))
                
                trailNode.position = SCNVector3(xAxis, yAxis, zAxis)
                for child in trailScene.rootNode.childNodes {
                    trailNode.addChildNode(child)
                }
                sceneView.scene.rootNode.addChildNode(trailNode)
                
                trailARNode.isTreasure = false
                trailARNode.isTextClue = false
                trailARNode.node = trailNode
                nodesArray.append(trailARNode)
            }
            
            //        if textClue == true{
            //
            //            textClueTextField.placeholder = "Write your text"
            //            self.view.addSubview(letterView)
            //
            //        }
            
            markTreasure = false
            textClue = false
            rightClue = false
            leftClue = false
            trailClue = false
            
        }
        
    }
    
    func addTapGestureToSceneView() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.addNode(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var index : Int = -1
        if nodesArray.count > 0 {
            for nodeCounter in 0 ... (nodesArray.count-1) {
                
                let touch = touches.first as! UITouch
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
                                
                                self.foundTreasureView.alpha = 1
                                self.view.addSubview(foundTreasureView)
                                autoLayoutView(viewAutoLayout: foundTreasureView)
                                forFinal = true
                                
                                self.treasureTipView.isHidden = true
                                
                                markTreasure = false
                                textClue = false
                                trailClue = false
                                rightClue = false
                                leftClue = false
                                forX = false
                                gameRunning = false
                                
                            }
                            
                        } else {
                            //                            if nodesArray[i].isTextClue == true {
                            //                                //textClueTextField.isHidden = true
                            //                                //textWrittenButton.isHidden = true
                            //                                //letterView.isHidden = true
                            //                            }
                            if nodesArray[nodeCounter].isTreasure == false {
                                index = nodeCounter
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
}
