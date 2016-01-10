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

  @objc required init?(coder aDecoder: NSCoder) {
    text = aDecoder.decodeObjectForKey("Text") as! String
    checked = aDecoder.decodeBoolForKey("Checked")
  }

  init(text: String, checked: Bool) {
    self.text = text
    self.checked = checked
  }

  func toggle() {
    self.checked = !self.checked
  }

  @objc func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(text, forKey: "Text")
    aCoder.encodeBool(checked, forKey: "Checked")
  }

}