//
//  CluesButtonsView.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 29/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import UIKit

class CluesButtons: UIView {
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
        Bundle.main.loadNibNamed("CluesButtons", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.clipsToBounds = true
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
    @IBAction func textCluePressed(_ sender: Any) {
        NotificationsFacade.shared.post(name: .addingTextClue, object: nil, userInfo: nil)
    }
    
    @IBAction func signCluePressed(_ sender: Any) {
        NotificationsFacade.shared.post(name: .addingSignClue, object: nil, userInfo: nil)
    }
    
    @IBAction func trailCluePressed(_ sender: Any) {
        NotificationsFacade.shared.post(name: .addingTrailClue, object: nil, userInfo: nil)
    }
}
