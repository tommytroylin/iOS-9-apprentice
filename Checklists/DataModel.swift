//
//  DataModel.swift
//  Checklists
//
//  Created by Keyu Lin on 1/12/16.
//  Copyright © 2016 Keyu Lin. All rights reserved.
//

import Foundation

class DataModel {
  var checklists = [Checklist]()

  init() {
    load()
    registerDefaults()
  }

  func save() {
    saveObject(checklists, forkey: "checklists")
  }

  func load() {
    if let checklistsFromFile = loadObjectByKey("checklists") as? [Checklist] {
      checklists = checklistsFromFile
    }
  }

  func registerDefaults() {
    NSUserDefaults.standardUserDefaults().registerDefaults(["ChecklistIndex": -1])
  }

  private func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    return paths[0]
  }

  private func dataFilePath() -> String {
    return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
  }

  private func saveObject(object: Array<NSCoding>, forkey key: String) {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    archiver.encodeObject(object, forKey: key)
    archiver.finishEncoding()
    data.writeToFile(dataFilePath(), atomically: true)
  }

  private func loadObjectByKey(key: String) -> AnyObject? {
    let path = dataFilePath()
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        let object = unarchiver.decodeObjectForKey(key)
        unarchiver.finishDecoding()
        return object
      }
      return nil
    }
    return nil
  }
}
