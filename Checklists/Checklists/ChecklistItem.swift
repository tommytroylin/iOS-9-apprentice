//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Keyu Lin on 12/27/15.
//  Copyright © 2015 Keyu Lin. All rights reserved.
//

import Foundation
import UIKit

class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  var dueDate: NSDate?
  var shouldRemind = false
  var itemID: Int

  @objc required init?(coder aDecoder: NSCoder) {
    text = aDecoder.decodeObjectForKey("Text") as! String
    checked = aDecoder.decodeBoolForKey("Checked")
    dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate?
    shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
    itemID = aDecoder.decodeIntegerForKey("ItemID")
    super.init()
  }

  init(text: String, checked: Bool) {
    self.text = text
    self.checked = checked
    self.itemID = DataModel.nextChecklistItemID()
  }

  func toggle() {
    self.checked = !self.checked
  }

  @objc func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(text, forKey: "Text")
    aCoder.encodeBool(checked, forKey: "Checked")
    aCoder.encodeObject(dueDate, forKey: "DueDate")
    aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
    aCoder.encodeInteger(itemID, forKey: "ItemID")
  }

  func scheduleNotification() {
    let existingNotification = notificationForThisItem()
    if let notification = existingNotification {
      print("Found an existing notification \(notification)")
      UIApplication.sharedApplication().cancelLocalNotification(notification)
    }
    if shouldRemind && dueDate?.compare(NSDate()) != .OrderedAscending {
      let localNotification = UILocalNotification()
      localNotification.fireDate = dueDate
      localNotification.timeZone = NSTimeZone.defaultTimeZone()
      localNotification.alertBody = text
      localNotification.soundName = UILocalNotificationDefaultSoundName
      localNotification.userInfo = ["ItemID": itemID]
      print("Register \(localNotification)")
      UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
  }

  func notificationForThisItem() -> UILocalNotification? {
    let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications!
    for notification in allNotifications {
      if let number = notification.userInfo?["ItemID"] as? Int where number == itemID {
        return notification
      }
    }
    return nil
  }

  deinit {
    if let notification = notificationForThisItem() {
      print("Removing existing notification \(notification)")
      UIApplication.sharedApplication().cancelLocalNotification(notification)
    }
  }
}