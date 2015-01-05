//
//  ViewController.swift
//  BullsEye
//
//  Created by Shaik MD Ashiq on 23/10/14.
//  Copyright (c) 2014 AK46. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue:Int=0
    var targetValue:Int=0
    var score=0
    var round=0
    
    //this is the slider outlet defined as instance variable for the other methods to use it
    
    @IBOutlet weak var slider: UISlider!
    
    //to display the target value in the screen for the user as a target
    
    @IBOutlet weak var targetLabel:UILabel!
    
    //to display the score
    
    @IBOutlet weak var scoreLabel:UILabel!
    
    //to display the rounds
    
    @IBOutlet weak var roundLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") { let trackLeftResizable =
            trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal) }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //func to start a new round
    
    func startNewRound()
    {
        targetValue=1+Int(arc4random_uniform(100))
        currentValue=50
        slider.value=Float(currentValue)
        round+=1
    }
    
    //func to show the tagetValue in the UI
    
    func updateLabels()
    {
        targetLabel.text=String(targetValue)
        scoreLabel.text=String(score)
        roundLabel.text=String(round)
    }
    
    //func to enable the startover button
    
    func startNewGame()
    {
        score=0;
        round=0;
        startNewRound();
    }
    
    //func to StartOver Button
    
    @IBAction func startOver()
    {
        startNewGame()
        updateLabels()
    }
    //func to show alert from the HIT ME button
  
    @IBAction func showAlert()
    {
        
       let difference=abs(currentValue - targetValue ) // calculate diff between the slider and target value
        
        var points=100-difference // calculate the points
        
        var title:String
        
        // to display the title msg
        if ( difference==0 )
        { title = "Perfect"
        points+=100}
        else if ( difference < 5)
        { title = "You almost had it"
        points+=50}
        else if (difference < 10)
        { title = "Pretty good" }
        else { title = " Not even Close" }
        
        score = score + points
     
        let message="You scored \(points) Points"
        
        let alert=UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action=UIAlertAction(title: "Ok", style: .Default, handler: {action in self.startNewRound()
            self.updateLabels()})
        
        alert.addAction(action)
        
        presentViewController(alert,animated:true,completion:nil)
    }

    //func to move slider
    
    @IBAction func sliderMoved(slider:UISlider)
    {
       currentValue=lroundf(slider.value)
    }

}

