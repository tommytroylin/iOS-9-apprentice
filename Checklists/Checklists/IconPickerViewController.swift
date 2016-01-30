//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by Keyu Lin on 1/27/16.
//  Copyright © 2016 Keyu Lin. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
  func iconPicker(picker: IconPickerViewController, didPickIcon iconName: String)
}

class IconPickerViewController: UITableViewController {
  weak var delegate: IconPickerViewControllerDelegate?
  let icons = ["No Icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"]

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return icons.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("IconCell", forIndexPath: indexPath)
    let iconName = icons[indexPath.row]
    cell.textLabel!.text = iconName
    cell.imageView!.image = UIImage(named: iconName)
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    delegate?.iconPicker(self, didPickIcon: icons[indexPath.row])
  }
}