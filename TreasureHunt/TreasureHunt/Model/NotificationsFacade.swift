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
    
    func post(name: NSNotification.Name, object: Any?, userInfo: [AnyHashable: Any]?) {
        self.notificationCenter.post(name: name, object: object, userInfo: userInfo)
    }
    
//    func post(name: NSNotification.Name, object: Any?) {
//        self.notificationCenter.post(name: name, object: object)
//    }
    
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        self.notificationCenter.addObserver(observer, selector: selector, name: name, object: object)
    }
    
}

extension Notification.Name {
    static var addingTextClue: Notification.Name {
        return .init("StateMachine.addingTextClue")
    }
    static var addingTrailClue: Notification.Name {
        return .init("StateMachine.addingTrailClue")
    }
    static var addingSignClue: Notification.Name {
        return .init("StateMachine.addingSignClue")
    }
    static var treasureFound: Notification.Name {
        return .init("StateMachine.treasureFound")
    }
    static var textClueTyped: Notification.Name {
        return .init("View.textClueTyped")
    }
    static var textClueTapped: Notification.Name {
        return .init("View.textClueTapped")
    }
    static var textClueNodeAdded: Notification.Name {
        return .init("View.textClueNodeAdded")
    }
    static var textClueRead: Notification.Name {
        return .init("View.textClueRead")
    }
} 
