//
// AddItemViewController.swift
// Checklists
//
// Created by Keyu Lin on 12/28/15.
// Copyright © 2015 Keyu Lin. All rights reserved.
//

import Foundation
import UIKit
class AddItemViewController: UITableViewController {
  
  @IBOutlet weak var textField: UITextField!

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
  
  @IBAction func cancel() {
    dismissViewControllerAnimated(true, completion: nil) 
  }
  
 @IBAction func done() {

    dismissViewControllerAnimated(true, completion: nil) 
  }

}