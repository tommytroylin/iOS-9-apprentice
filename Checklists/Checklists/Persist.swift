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

  class func saveObject(object: Array<NSCoding>, forkey key: String) {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    archiver.encodeObject(object, forKey: key)
    archiver.finishEncoding()
    data.writeToFile(dataFilePath(), atomically: true)
  }

  class func loadObjectByKey(key: String) -> AnyObject? {
    let path = dataFilePath()
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        let objects = unarchiver.decodeObjectForKey(key)
        unarchiver.finishDecoding()
        return objects
      }
      return nil
    }
    return nil
  }

}
