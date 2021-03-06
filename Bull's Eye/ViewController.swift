//
//  ViewController.swift
//  Bull's Eye
//
//  Created by Mario Alberto Gonzalez on 17/01/17.
//  Copyright © 2017 Mario Alberto Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIforSlider()
        startNewRound()
        updateLabels()
    }
    
    func setUIforSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        
        slider.setThumbImage(thumbImageNormal, for: .normal)
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
    }
    
    func startNewRound() {
        currentValue = 50;
        targetValue = Int(arc4random_uniform(100)) + 1
        slider.value = Float(currentValue)
        round += 1
    }
    
    func updateLabels(){
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
    func getTitleWithDifference(_ difference: Int) -> String {
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        return title
    }

    @IBAction func showMe() {
        let difference = abs(currentValue - targetValue)
        let points = 100 - difference
        let title = self.getTitleWithDifference(difference)
        score += points
        
        let message = "You score \(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default,
                                   handler: {
                                            action in
                                            self.startNewRound()
                                            self.updateLabels()
                                            })
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        print("The value of the slider is now \(slider.value)")
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        score = 0
        round = 0
        startNewRound()
        updateLabels()
    }
}

