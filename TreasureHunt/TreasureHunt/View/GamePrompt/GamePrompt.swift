//
//  GamePrompt.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 30/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//
import Foundation

import UIKit

class GamePrompt: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    var text = ""
    var timer: Timer!
    var counter = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("GamePrompt", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.clipsToBounds = true
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
        contentLabel.text! = ""
    }
    
    func typeLetter(text: String) {
        self.counter = 0
        self.contentLabel.text = ""
        self.text = text
        self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(animation), userInfo: nil, repeats: false)
    }
    
    @objc func animation() {
        if self.counter < self.text.count {
            let index = self.text.index(self.text.startIndex, offsetBy: self.counter)
            self.contentLabel.text! += String(self.text[index])
            let randomInterval = Double((arc4random_uniform(3)+1))/20
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector: #selector(animation), userInfo: nil, repeats: false)
        }
        self.counter += 1
    }
}
