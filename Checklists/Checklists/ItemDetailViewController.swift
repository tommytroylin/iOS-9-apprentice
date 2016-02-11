//
// ItemDetailViewController.swift
// Checklists
//
// Created by Keyu Lin on 12/28/15.
// Copyright © 2015 Keyu Lin. All rights reserved.
//

import Foundation
import UIKit

protocol ItemDetailViewControllerDelegate: class {
  func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)

  func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)

  func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

  @IBOutlet weak var shouldRemindSwitch: UISwitch!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneButton: UIBarButtonItem!
  @IBOutlet weak var dueDateLabel: UILabel!
  @IBOutlet weak var datePickerCell: UITableViewCell!
  @IBOutlet weak var datePicker: UIDatePicker!

  @IBAction func dateChanged(datePicker: UIDatePicker) {
    dueDate = datePicker.date
    doneButton.enabled = true
    updateDueDateLabel()
  }

  @IBAction func remindMeToggle(uiSwitch: UISwitch) {
    doneButton.enabled = true
  }

  var dueDate: NSDate?
  weak var delegate: ItemDetailViewControllerDelegate?
  var itemToEdit: ChecklistItem?
  var datePickerVisible = false

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 1 && datePickerVisible {
      return 3
    } else {
      return super.tableView(tableView, numberOfRowsInSection: section)
    }
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.section == 1 && indexPath.row == 2 {
      return datePickerCell
    } else {
      return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
  }

  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if indexPath.section == 1 && indexPath.row == 2 {
      return 217
    } else {
      return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
  }

  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    if indexPath.section == 1 && indexPath.row == 1 {
      return indexPath
    } else {
      return nil
    }
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 1 && indexPath.row == 1 {
      if datePickerVisible {
      hideDatePicker()
      }
      else {
     showDatePicker()
     }
    }
  }

  override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
    if indexPath.section == 1 && indexPath.row == 2 {
      let newIndexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
      return super.tableView(tableView, indentationLevelForRowAtIndexPath: newIndexPath)
    }
    return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)
  }

  @IBAction func cancel() {
    delegate?.itemDetailViewControllerDidCancel(self)
  }

  @IBAction func done() {
    if let editedItem = itemToEdit {
      editedItem.text = textField.text!
      editedItem.shouldRemind = shouldRemindSwitch.on
      editedItem.dueDate = dueDate
      delegate?.itemDetailViewController(self, didFinishEditingItem: editedItem)
    } else {
      let newItem = ChecklistItem(text: textField.text!, checked: false)
      newItem.shouldRemind = shouldRemindSwitch.on
      newItem.dueDate = dueDate
      delegate?.itemDetailViewController(self, didFinishAddingItem: newItem)
    }
  }

  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    let newString: NSString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
    self.doneButton.enabled = (newString.length != 0)
    return true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    if let item = itemToEdit {
      title = "Edit Item"
      textField.text = item.text
      shouldRemindSwitch.on = item.shouldRemind
      dueDate = item.dueDate
      updateDueDateLabel()
    }
  }

  func updateDueDateLabel() {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    formatter.timeStyle = .ShortStyle
    if let displayDate = dueDate {
      dueDateLabel.text = formatter.stringFromDate(displayDate)
    } else {
      dueDateLabel.text = "Not Set."
    }
  }

  func showDatePicker() {
    datePickerVisible = true
    let indexPathDatePicker = NSIndexPath(forRow: 2, inSection: 1)
    tableView.insertRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
    if let _ = dueDate {
      datePicker.setDate(dueDate!, animated: false)
    }

  }

  func hideDatePicker() {
    datePickerVisible = false
    let indexPathDatePicker = NSIndexPath(forRow: 2, inSection: 1)
    tableView.deleteRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
  }

}