////
////  NotScreens.swift
////  hunt
////
////  Created by Manuella Valença on 28/04/2018.
////  Copyright © 2018 Manuella Valença. All rights reserved.
////
//
//import UIKit
//import Foundation
//
//extension ViewController{
//
//    func introductionScreen(appears state: Bool){
//
//        backgroundImage.isHidden = !state
//        startButton.isHidden = !state
//        trailImage.isHidden = !state
//        logoImage.isHidden = !state
//
//        if state == true{
//            storyScreen(appears: false)
//            hideScreen(appears: false)
//            markTreasureLocationScreen(appears: false)
//            createMapScreen(appears: false)
//            cluesScreen(appears: false)
//            changeCharacterScreen(appears: false)
//            seekScreen(appears: false)
//            treasureFoundScreen(appears: false)
//
//            backButton.isHidden = true
//            textClueTextField.isHidden = true
//            textTextClueView.isHidden = true
//
//            markTreasure = false
//            textClue = false
//            trailClue = false
//        }
//    }
//
//    func storyScreen(appears state: Bool){
//
//        seloButton.isHidden = !state
//
//        storyScreenImage.isHidden = !state
//
//        if state == true{
//            introductionScreen(appears: false)
//            hideScreen(appears: false)
//            markTreasureLocationScreen(appears: false)
//            createMapScreen(appears: false)
//            cluesScreen(appears: false)
//            changeCharacterScreen(appears: false)
//            seekScreen(appears: false)
//            treasureFoundScreen(appears: false)
//            backButton.isHidden = !state
//            textClueTextField.isHidden = true
//            textTextClueView.isHidden = true
//        }
//    }
//
//    func hideScreen(appears state: Bool){
//
//        hideCharacterBackground.isHidden = !state
//
//        trail3Image.isHidden = !state
//        treasureChoosedButton.isHidden = !state
//        treasureTipTextField.isHidden = !state
//
//        treasureTipTextField.placeholder = "Treasure's tip"
//
//        if state == true{
//
//            introductionScreen(appears: false)
//            storyScreen(appears: false)
//            markTreasureLocationScreen(appears: false)
//            createMapScreen(appears: false)
//            cluesScreen(appears: false)
//            changeCharacterScreen(appears: false)
//            seekScreen(appears: false)
//            treasureFoundScreen(appears: false)
//
//
//            textClueTextField.isHidden = true
//            textTextClueView.isHidden = true
//        }
//    }
//
//    func markTreasureLocationScreen(appears state: Bool){
//        treasureLocationImage.isHidden = !state
//        remarkTreasureLocationButton.isHidden = !state
//        markTreasureLocationButton.isHidden = !state
//        markXImage.isHidden = !state
//
//        if state == true{
//            setUpSceneView()
//            introductionScreen(appears: false)
//            storyScreen(appears: false)
//            hideScreen(appears: false)
//            createMapScreen(appears: false)
//            cluesScreen(appears: false)
//            changeCharacterScreen(appears: false)
//            seekScreen(appears: false)
//            treasureFoundScreen(appears: false)
//            textClueTextField.isHidden = true
//            textTextClueView.isHidden = true
//            backButton.isHidden = true
//        }
//    }
//
//    func createMapScreen(appears state: Bool){
//        clueLabelView.isHidden = !state
//        addClueButton.isHidden = !state
//
//        if state == true{
//            introductionScreen(appears: false)
//            storyScreen(appears: false)
//            hideScreen(appears: false)
//            markTreasureLocationScreen(appears: false)
//            cluesScreen(appears: false)
//            changeCharacterScreen(appears: false)
//            seekScreen(appears: false)
//            treasureFoundScreen(appears: false)
//            textClueTextField.isHidden = true
//            textTextClueView.isHidden = true
//        }
//    }
//
//    func cluesScreen(appears state: Bool){
//        clueInfoLabelView.isHidden = !state
//        clueFinishedButton.isHidden = !state
//
//        cluesStylesView.isHidden = !state
//
//        if state == true{
//            introductionScreen(appears: false)
//            storyScreen(appears: false)
//            hideScreen(appears: false)
//            markTreasureLocationScreen(appears: false)
//            createMapScreen(appears: false)
//            changeCharacterScreen(appears: false)
//            seekScreen(appears: false)
//            treasureFoundScreen(appears: false)
//            textClueTextField.isHidden = true
//            textTextClueView.isHidden = true
//        }
//    }
//
//    func changeCharacterScreen(appears state: Bool){
//
//        changeCharacterView.isHidden = !state
//        startHuntButton.isHidden = !state
//
//        if state == true{
//            introductionScreen(appears: false)
//            storyScreen(appears: false)
//            hideScreen(appears: false)
//            markTreasureLocationScreen(appears: false)
//            createMapScreen(appears: false)
//            cluesScreen(appears: false)
//            seekScreen(appears: false)
//            treasureFoundScreen(appears: false)
//            textClueTextField.isHidden = true
//            textTextClueView.isHidden = true
//        }
//    }
//
//
//
//    func seekScreen(appears state: Bool){
//
//        seekCharacterView.isHidden = !state
//        treasureTipView.isHidden = !state
//
//        if state == true{
//            introductionScreen(appears: false)
//            storyScreen(appears: false)
//            hideScreen(appears: false)
//            markTreasureLocationScreen(appears: false)
//            createMapScreen(appears: false)
//            cluesScreen(appears: false)
//            changeCharacterScreen(appears: false)
//            treasureFoundScreen(appears: false)
//            textClueTextField.isHidden = true
//            textTextClueView.isHidden = true
//            backButton.isHidden = true
//
//            gameRunning = true
//        }
//    }
//
//
//    func treasureFoundScreen(appears state: Bool){
//         viewFinal.isHidden  = !state
//        buttonFinal.isHidden = !state
//        forFinal = true
//
//
//        if state == true{
//            introductionScreen(appears: false)
//            storyScreen(appears: false)
//            hideScreen(appears: false)
//            markTreasureLocationScreen(appears: false)
//            createMapScreen(appears: false)
//            cluesScreen(appears: false)
//            seekScreen(appears: false)
//            changeCharacterScreen(appears: false)
//
//            textClueTextField.isHidden = true
//            textTextClueView.isHidden = true
//        }
//    }
//
//}
