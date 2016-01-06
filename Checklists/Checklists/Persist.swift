//
//  Persist.swift
//  Checklists
//
//  Created by Keyu Lin on 1/30/16.
//  Copyright © 2016 Keyu Lin. All rights reserved.
//

import Foundation

class Persist {
  class func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    return paths[0]
  }

  class func dataFilePath() -> String {
    return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
  }

  class func saveChecklistItems(checklistItems: Array<NSCoding>) {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    archiver.encodeObject(checklistItems, forKey: "ChecklistItems")
    archiver.finishEncoding()
    data.writeToFile(dataFilePath(), atomically: true)
  }

  class func loadChecklistItems() -> Array<ChecklistItem> {
    return []
  }

}
