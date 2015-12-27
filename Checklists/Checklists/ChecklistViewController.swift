//
//  ViewController.swift
//  Checklists
//
//  Created by Keyu Lin on 12/27/15.
//  Copyright © 2015 Keyu Lin. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier( "ChecklistItem", forIndexPath: indexPath)
    let label = cell.viewWithTag(1000) as! UILabel

    if indexPath.row == 0 {
      label.text = "Walk the dog"
    } else if indexPath.row == 1 {
      label.text = "Brush my teeth"
    } else if indexPath.row == 2 {
      label.text = "Learn iOS development"
    } else if indexPath.row == 3 {
      label.text = "Soccer practice"
    } else if indexPath.row == 4 {
      label.text = "Eat ice cream"
    }
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      if cell.accessoryType == .None {
        cell.accessoryType = .Checkmark
      } else {
        cell.accessoryType = .None
      }
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }


}