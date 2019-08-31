//
//  TapView.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 30/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import UIKit

class TapView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
