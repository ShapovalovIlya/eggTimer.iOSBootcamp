//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer?
    
    let eggTimes = [
        "Soft": 300,
        "Medium": 420,
        "Hard": 720
    ]
    

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        guard let eggStatus = sender.currentTitle else { return }
        guard let hardness = eggTimes[eggStatus] else { return }
        print(hardness)
        timeRemaining(time: hardness)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeRemaining), userInfo: nil, repeats: true)
        
    }
    
    @objc func timeRemaining(time: Int) {
        var timeLeft = time
        
        if timeLeft > 0 {
            timeLeft -= 1
            print("It's \(timeLeft) left")
        } else {
            timer?.invalidate()
        }
    }
    
}
