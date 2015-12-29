//
// ViewController.swift
// Checklists
//
// Created by Keyu Lin on 12/27/15.
// Copyright © 2015 Keyu Lin. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
  var checklistItems = [ChecklistItem]()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.checklistItems.append(ChecklistItem(text: "Walk the dog", checked: false))
    self.checklistItems.append(ChecklistItem(text: "Learn iOS development", checked: true))
    self.checklistItems.append(ChecklistItem(text: "Soccer practice", checked: false))
    self.checklistItems.append(ChecklistItem(text: "Eat ice cream", checked: true))
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    self.checklistItems.removeAtIndex(indexPath.row)
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    if segue.identifier == "AddItem" {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! AddItemViewController
      controller.delegate = self
    }
  }


  func addItemViewControllerDidCancel(controller: AddItemViewController) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }

  func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
    self.checklistItems.append(item)
    let indexPath = NSIndexPath(forRow: self.checklistItems.count - 1, inSection: 0)
    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    controller.dismissViewControllerAnimated(true, completion: nil)
  }

}
