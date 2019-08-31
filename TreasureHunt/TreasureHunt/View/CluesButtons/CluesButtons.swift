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
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var trailButton: UIButton!
    
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
        NotificationsFacade.shared.post(name: .addingTextClue, object: nil)
    }
    
    @IBAction func signCluePressed(_ sender: Any) {
    }
    
    @IBAction func trailCluePressed(_ sender: Any) {
    }
}
