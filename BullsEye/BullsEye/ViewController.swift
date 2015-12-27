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
    var round = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.newTargetValue()
        self.updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable =
            trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
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
        self.round = 1
        self.newTargetValue()
        self.updateLabels()
        
    }
    
    
}

