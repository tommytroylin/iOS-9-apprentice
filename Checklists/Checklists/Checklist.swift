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

  @objc required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey("name") as! String
    items = aDecoder.decodeObjectForKey("items") as! [ChecklistItem]
  }

  init(name: String) {
    self.name = name
    self.items = [ChecklistItem]()
    super.init()
  }

  @objc func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: "name")
    aCoder.encodeObject(items, forKey: "items")
  }

}
