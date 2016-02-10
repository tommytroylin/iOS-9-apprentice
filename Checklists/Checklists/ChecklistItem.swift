//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Keyu Lin on 12/27/15.
//  Copyright © 2015 Keyu Lin. All rights reserved.
//

import Foundation

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

}