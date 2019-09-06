//
//  ARButton.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 30/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//
import UIKit

@IBDesignable
class ARButton: UIButton {
    
    @IBInspectable var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
            self.setTitleColor(UIColor.green, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        let image = UIImage(named:"Asset 1hunt")
        self.setImage(image, for: UIControl.State.normal)
        self.imageView?.contentMode = .scaleAspectFit
    }
}
