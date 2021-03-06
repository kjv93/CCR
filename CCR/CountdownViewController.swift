//
//  CountdownViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/10/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit
import AVFoundation

class CountdownViewController: UIViewController {
    
    var timeRemaining = 1500.0
    var totalTime = 1500.0
    var timer = Timer()
    var timerIsOn = false
    var buttonSound = AVAudioPlayer()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBAction func clearBtnTapped(_ sender: Any) {
        timer.invalidate()
        timeRemaining = 1500
        timeLabel.text = "25:00"
        timerIsOn = false
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        
        if !timerIsOn {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    
    @IBAction func pauseBtnTapped(_ sender: Any) {
        timer.invalidate()
        timerIsOn = false
    }
    
    func timerRunning() {
        timeRemaining -= 1
        let completionPercentage = Int((Float(timeRemaining)/Float(totalTime)) * 100)
        progressLabel.text = "\(completionPercentage)%"
        let minutesLeft = Int(timeRemaining) / 60 % 60
        let secondsLeft = Int(timeRemaining) % 60
        timeLabel.text = "\(minutesLeft):\(secondsLeft)"
        
        if timeRemaining == 0 {
            timer.invalidate()
            timeLabel.text = "Time's Up!"
            buttonSound.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try buttonSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "double_ring_from_desk_bell", ofType: "mp3")!))
        } catch {
            print(error.localizedDescription)
            print("Error: There's an error with the audio file named double_ring_from_desk_bell.mp3")
        }
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
