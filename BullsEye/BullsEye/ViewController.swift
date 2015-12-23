//
//  ViewController.swift
//  BullsEye
//
//  Created by Keyu Lin on 12/21/15.
//  Copyright © 2015 Keyu Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        let alert = UIAlertController(title: "Result",
            message: "Slider result:\(lroundf(slider.value))", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK!", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

