//
// ViewController.swift
// Checklists
//
// Created by Keyu Lin on 12/27/15.
// Copyright © 2015 Keyu Lin. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
  var checklistItems = [ChecklistItem]()
  var checklist: Checklist!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    let path = Persist.dataFilePath()
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        checklistItems = unarchiver.decodeObjectForKey("ChecklistItems") as! [ChecklistItem]
        unarchiver.finishDecoding()
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = checklist.name
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return checklistItems.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = self.checklistItems[indexPath.row].text
    let checkLable = cell.viewWithTag(1001) as! UILabel
    checkLable.hidden = !self.checklistItems[indexPath.row].checked
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      self.checklistItems[indexPath.row].toggle()
      let checkLable = cell.viewWithTag(1001) as! UILabel
      checkLable.hidden = !self.checklistItems[indexPath.row].checked
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    Persist.saveChecklistItems(checklistItems)
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    self.checklistItems.removeAtIndex(indexPath.row)
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    Persist.saveChecklistItems(checklistItems)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    if segue.identifier == "AddItem" {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! ItemDetailViewController
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! ItemDetailViewController
      controller.delegate = self
      if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
        controller.itemToEdit = checklistItems[indexPath.row]
      }
    }
  }

  func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }

  func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
    if let index = checklistItems.indexOf({ $0 === item }) {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        (cell.viewWithTag(1000) as! UILabel).text = item.text
      }
    }
    controller.dismissViewControllerAnimated(true, completion: nil)
    Persist.saveChecklistItems(checklistItems)
  }

  func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
    self.checklistItems.append(item)
    let indexPath = NSIndexPath(forRow: self.checklistItems.count - 1, inSection: 0)
    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    controller.dismissViewControllerAnimated(true, completion: nil)
    Persist.saveChecklistItems(checklistItems)
  }
}
