//
// ViewController.swift
// Checklists
//
// Created by Keyu Lin on 12/27/15.
// Copyright © 2015 Keyu Lin. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
  var checklist: Checklist!

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
    return checklist.items.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = self.checklist.items[indexPath.row].text
    let checkLable = cell.viewWithTag(1001) as! UILabel
    checkLable.hidden = !self.checklist.items[indexPath.row].checked
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      self.checklist.items[indexPath.row].toggle()
      let checkLable = cell.viewWithTag(1001) as! UILabel
      checkLable.hidden = !self.checklist.items[indexPath.row].checked
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    self.checklist.items.removeAtIndex(indexPath.row)
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
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
        controller.itemToEdit = checklist.items[indexPath.row]
      }
    }
  }

  func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }

  func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
    if let index = checklist.items.indexOf({ $0 === item }) {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        (cell.viewWithTag(1000) as! UILabel).text = item.text
      }
    }
    controller.dismissViewControllerAnimated(true, completion: nil)
  }

  func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
    self.checklist.items.append(item)
    let indexPath = NSIndexPath(forRow: self.checklist.items.count - 1, inSection: 0)
    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
}
