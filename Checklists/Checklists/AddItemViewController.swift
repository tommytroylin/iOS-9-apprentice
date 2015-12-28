//
// AddItemViewController.swift
// Checklists
//
// Created by Keyu Lin on 12/28/15.
// Copyright © 2015 Keyu Lin. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate : class {
  func addItemViewControllerDidCancel(controller: AddItemViewController)
  func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) 
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneButton: UIBarButtonItem!
  weak var delegate: AddItemViewControllerDelegate?
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }

  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
  
  @IBAction func cancel() {
    delegate?.addItemViewControllerDidCancel(self)
  }
  
 @IBAction func done() {
    delegate?.addItemViewController(self, didFinishAddingItem:ChecklistItem(text: textField.text!, checked: false))
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    let newString: NSString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
    self.doneButton.enabled = (newString.length != 0)
    return true
  }
  
}