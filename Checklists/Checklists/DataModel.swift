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
  var indexOfSelectedChecklist: Int {
    get {
      return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
    }
    set {
      NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
    }
  }

  init() {
    load()
    registerDefaults()
    handleFirstTime()
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
    NSUserDefaults.standardUserDefaults().registerDefaults([
      "ChecklistIndex": -1,
      "FirstTime": true,
      "ChecklistItemID":0,
      ])
  }

  func handleFirstTime() {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let firstTime = userDefaults.boolForKey("FirstTime")
    if firstTime {
      let checklist = Checklist(name: "List")
      checklists.append(checklist)
      indexOfSelectedChecklist = 0
      userDefaults.setBool(false, forKey: "FirstTime")
      userDefaults.synchronize()
    }
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

  class func nextChecklistItemID() -> Int {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let itemID = userDefaults.integerForKey("ChecklistItemID")
    userDefaults.setInteger(itemID + 1, forKey: "ChecklistItemID")
    userDefaults.synchronize()
    return itemID
  }
}
