//
//  NotificationsFacade.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 29/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import Foundation

class NotificationsFacade {
    static let shared = NotificationsFacade()
    private var notificationCenter = NotificationCenter()
    
    func post(name: NSNotification.Name, object: Any?) {
        self.notificationCenter.post(name: name, object: object)
    }
    
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        self.notificationCenter.addObserver(observer, selector: selector, name: name, object: object)
    }
}

extension Notification.Name {
    static var showCluesButtons: Notification.Name {
        return .init("View.showCluesButtons")
    }
    static var addingTextClue: Notification.Name {
        return .init("StateMachine.addingTextClue")
    }
}

