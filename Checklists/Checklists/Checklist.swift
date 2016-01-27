//
//  Checklist.swift
//  Checklists
//
//  Created by Keyu Lin on 1/2/16.
//  Copyright © 2016 Keyu Lin. All rights reserved.
//

import Foundation

class Checklist: NSObject, NSCoding {
  var name = ""
  var items: [ChecklistItem]
  var iconName: String

  @objc required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey("name") as! String
    items = aDecoder.decodeObjectForKey("items") as! [ChecklistItem]
    iconName = aDecoder.decodeObjectForKey("iconName") as! String
    super.init()
  }

  init(name: String) {
    self.name = name
    self.items = [ChecklistItem]()
    self.iconName = "Appointments"
    super.init()
  }

  @objc func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: "name")
    aCoder.encodeObject(items, forKey: "items")
    aCoder.encodeObject(iconName, forKey: "iconName")
  }

  func countUncheckedItems() -> Int {
    return items.reduce(0, combine: { $0 + ($1.checked ? 0 : 1) })
  }

  func sortItems() {
    items.sortInPlace({$0.text.localizedStandardCompare($1.text) == .OrderedAscending})
  }

}
