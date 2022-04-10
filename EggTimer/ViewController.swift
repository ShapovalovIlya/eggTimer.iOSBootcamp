//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    var timer = Timer()
    var totalTime = 0
    var secondsPast = 0
    
    let eggTimes = [
        "Soft": 300,
        "Medium": 420,
        "Hard": 720
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "How do you like your eggs?"
        progressBar.progress = 0.0
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        guard let hardness = sender.currentTitle else { return }
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        titleLabel.text = hardness
       
        timer(secondsRemainig: totalTime)
        
    }
    
   //Creating function for set timer
    func timer(secondsRemainig: Int) {
            
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.secondsPast < self.totalTime {
                self.secondsPast += 1
                //Created property that represent progress in percentage for the progressView
                let percentageProgress = Float(self.secondsPast) / Float(self.totalTime)

                self.progressBar.progress = percentageProgress
                print(percentageProgress)
            } else {
                self.timer.invalidate()
                self.titleLabel.text = "Done!"
                self.alarmSound()
            }
        }
    }
    //Function for making alarm-sound
    func alarmSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: ".mp3") else { return }
                
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let safePlayer = player else { return }
            safePlayer.play()
        }
        catch {
            print("Something went wrong!")
            return
        }
    }
    
}
