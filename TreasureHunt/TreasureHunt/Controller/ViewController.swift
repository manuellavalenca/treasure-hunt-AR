//
//  ViewController.swift
//  hunt
//
//  Created by Manuella Valença on 28/04/2018.
//  Copyright © 2018 Manuella Valença. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, UITextFieldDelegate {
    var musicPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playMusicButton(_ sender: Any) {
//        if musicPlaying == true {
//            backgroundMusic.pause()
//            som.setImage(UIImage(named: "speaker-2.png"), for: .normal)
//            musicPlaying = false
//        } else {
//            backgroundMusic.play()
//            som.setImage(UIImage(named: "speaker.png"), for: .normal)
//            musicPlaying = true
//        }
    }
    
    // MARK: - Pop ups animations
    func cluesPopupsAnimation() {
//        self.touchScreenPopUp.alpha = 1
//        self.chooseHintPopUp.alpha = 1
//        self.view.bringSubviewToFront(touchScreenPopUp)
//        self.view.bringSubviewToFront(chooseHintPopUp)
//        if movedForForeground == false {
//            chooseHintPopUp.center.y -= chooseHintPopUp.frame.height
//            touchScreenPopUp.center.y -= touchScreenPopUp.frame.height
//        } else {
//            chooseHintPopUp.center.y -= chooseHintPopUp.frame.height
//            touchScreenPopUp.center.y -= touchScreenPopUp.frame.height
//        }
//        autoLayoutPopups(popup: chooseHintPopUp)
//        self.view.addSubview(chooseHintPopUp)
//        autoLayoutPopups(popup: touchScreenPopUp)
//        self.view.addSubview(touchScreenPopUp)
//        UIView.animate(withDuration: 1, delay: 0.3, options: [], animations: {
//            self.chooseHintPopUp.center.y += self.chooseHintPopUp.frame.height
//        }, completion: {(_) in
//            UIView.animate(withDuration: 1, delay: 2, options: [], animations: {
//                self.chooseHintPopUp.center.y -= self.chooseHintPopUp.frame.height
//            }, completion: {(_) in
//                UIView.animate(withDuration: 1, delay: 0.3, options: [], animations: {
//                    self.touchScreenPopUp.center.y += self.touchScreenPopUp.frame.height
//                }, completion: {(_) in
//                    UIView.animate(withDuration: 1, delay: 3, options: [], animations: {
//                        self.touchScreenPopUp.center.y -= self.touchScreenPopUp.frame.height
//                    }, completion: nil)
//                })
//            })
//        })
    }
    
    @objc func appWillEnterForeground() {
        // CHANGE STATE TO MAPPINGLOST
    }
}
