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

  var dueDate:NSDate?
  weak var delegate: ItemDetailViewControllerDelegate?
  var itemToEdit: ChecklistItem?

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }

  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
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
}