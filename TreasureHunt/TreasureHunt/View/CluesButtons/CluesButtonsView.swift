//
//  CluesButtonsView.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 29/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import UIKit

class CluesButtonsView: UIView {
    @IBOutlet var contentView: UIView!
    
    let contentName = "CluesButtons"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(contentName, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    @IBAction func textCluePressed(_ sender: Any) {
        NotificationsFacade.shared.post(name: .addingTextClue, object: nil)
    }
    
    @IBAction func signCluePressed(_ sender: Any) {
    }
    
    @IBAction func trailCluePressed(_ sender: Any) {
    }
    
}

extension UIView {
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
