//
//  ShowTextClue.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 05/09/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import Foundation

import UIKit

class ShowTextClue: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ShowTextClue", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.clipsToBounds = true
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
}
