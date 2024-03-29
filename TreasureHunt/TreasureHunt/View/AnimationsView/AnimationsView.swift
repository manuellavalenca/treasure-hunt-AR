//
//  AnimationsView.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 30/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import UIKit

class AnimationsView: UIView {
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("AnimationsView", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.clipsToBounds = true
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
}
