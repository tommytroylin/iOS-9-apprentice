//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Keyu Lin on 1/5/16.
//  Copyright © 2016 Keyu Lin. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class{
  func listDetailViewControllerDidCancel(controller: ListDetailViewController)
  func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)
  func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)
 }

class ListDetailViewController: UITableViewController, UITextFieldDelegate {

  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var textField: UITextField!
  weak var delegate: ListDetailViewControllerDelegate?
  var checklistToEdit: Checklist?


  @IBAction func cancel() {
    delegate?.listDetailViewControllerDidCancel(self)
  }


  @IBAction func done() {
    if let checklist = checklistToEdit {
      checklist.name = textField.text!
      delegate?.listDetailViewController(self,didFinishEditingChecklist: checklist)
    } else {
      let checklist = Checklist(name: textField.text!)
      delegate?.listDetailViewController(self,didFinishAddingChecklist: checklist)
    }


  }
  override func viewDidLoad() {
    super.viewDidLoad()
    if let checklist = checklistToEdit {
      title = "Edit Checklist"
      textField.text = checklist.name
      doneBarButton.enabled = true
    }
  }
  

  override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
  }

  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
      return nil
  }

  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
      let oldText: NSString = textField.text!
      let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
      doneBarButton.enabled = (newText.length > 0)
      return true
  }
}