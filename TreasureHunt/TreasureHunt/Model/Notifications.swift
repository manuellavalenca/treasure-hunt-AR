//
//  Notifications.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 28/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//
import NotificationCenter

class Notifications {
    static let shared = Notifications()
    private var notificationCenter = NotificationCenter()
    
    func post(name aName: NSNotification.Name, object anObject: Any?) {
        self.notificationCenter.post(name: aName, object: anObject)
    }
    
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?) {
        self.notificationCenter.addObserver(observer, selector: aSelector, name: aName, object: anObject)
    }
    
    func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]? = nil) {
        self.notificationCenter.post(name: aName, object: anObject, userInfo: aUserInfo)
    }
}

extension Notification.Name {
    static var changeGoalCardState: Notification.Name {
        return .init(rawValue: "System.changeGoalCardState")
}
