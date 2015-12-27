//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Keyu Lin on 12/27/15.
//  Copyright © 2015 Keyu Lin. All rights reserved.
//

import Foundation

class ChecklistItem {
  var text = ""
  var checked = false

  init(text:String,checked:Bool){
    self.text = text
    self.checked = checked
  }
  
  func toggle() {
    self.checked = !self.checked
  }
}