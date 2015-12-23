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
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.newTargetValue()
        self.updateLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateLabels(){
        self.targetLabel.text = "\(self.targetValue)"
        self.scoreLabel.text = "\(self.score)"
        self.roundLabel.text = "\(self.round)"
    }
    
    func finishRound(score: Int){
        self.score += score
        self.round++
    }
    
    func newTargetValue() {
        self.targetValue = 1 + Int(arc4random_uniform(100))
    }
    
    func calculateScore() -> Int {
        return 100 - abs(targetValue - lroundf(slider.value))
    }
    
    @IBAction func showAlert() {
        let score = self.calculateScore()
        let message = "Slider value is:\(lroundf(slider.value))\n Target value is:\(targetValue)\n Your score is:\(score)"
        let alert = UIAlertController(title: "Result",
            message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Next!", style: .Default, handler: {(action) in
            self.finishRound(score)
            self.newTargetValue()
            self.updateLabels()
        })
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)

    }

    @IBAction func startOver() {
        self.score = 0
        self.round = 0
        self.newTargetValue()
        self.updateLabels()
        
    }
    
    
}

