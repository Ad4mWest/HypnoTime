//  TimerLogic .swift
//  MotivationTimer
//  Created by Adam West on 23.05.23.

import UIKit
import AVFoundation


class TimerLogic {
   
    var viewController: ViewController?
    var statistics: Statistics!

    init(viewController: ViewController) {
       self.viewController = viewController
       statistics = Statistics()
   }
    
    let imageArray = (0...11).map { UIImage(named: "\($0)")!}

    var seconds = 60
    private var hours = 0
    var timer = Timer()
    private var audioPlayer = AVAudioPlayer()
    
    func enableOfButtons(start: Bool, pause: Bool, restart: Bool) {
        self.viewController?.startButton.isEnabled = start
        self.viewController?.pauseButton.isEnabled = pause
        self.viewController?.restartButton.isEnabled = restart
    }
    
    func isUserInteractionEnabled(yes: Bool) {
        self.viewController?.minuteCountPicker.isUserInteractionEnabled = yes
    }
    
    func addVibration() {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate), {})
    }
    
    func addMusic() {
        let fileURL = Bundle.main.url(forResource: "MagneticScope-AxelF", withExtension: "mp3")
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: fileURL!)
            self.audioPlayer.prepareToPlay()
        } catch {
            print("Error loading sound file")
        }
    }
    
    func animate(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images
        imageView.animationDuration = 1.0
        //imageView.animationRepeatCount = 1
        imageView.startAnimating()
    }
    
    func hoursGone() {
        self.viewController?.hoursGoneLabel.text = "Today: \(self.hours) / Total: \(String(describing: self.statistics.total))"
            }
    
    func timerStart() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.seconds > 0 {
                self.seconds -= 1
                let sec = self.seconds % 60
                let min = self.seconds / 60 % 60
                self.viewController?.secondsLabel.text = String(format:"%2i:%2i", min, sec)
                enableOfButtons(start: false, pause: true, restart: true)
                isUserInteractionEnabled(yes: false)
                audioPlayer.stop()
                
                animate(imageView: (viewController?.gifAnimationImage)!, images: imageArray)
            } else {
                self.timer.invalidate()
                self.seconds = 60 * ((self.viewController?.minuteCountPicker.selectedRow(inComponent: 0) ?? 0) + 1)
                self.viewController?.secondsLabel.text = "Done!"
                self.hours += 1
                self.statistics.total += 1
                hoursGone()
                
                enableOfButtons(start: true, pause: false, restart: true)
                isUserInteractionEnabled(yes: true)
                
                addMusic()
                audioPlayer.volume = 1
                audioPlayer.play()
                addVibration()
            }
        }
        addVibration()
    }
    
    func timerPause() {
        timer.invalidate()
        enableOfButtons(start: true, pause: false, restart: true)
        isUserInteractionEnabled(yes: false)
        addVibration()
    }
    func timerRestart() {
        timer.invalidate()
        seconds = 60 * ((self.viewController?.minuteCountPicker.selectedRow(inComponent: 0) ?? 0) + 1)
        self.viewController?.secondsLabel.text = "Done!"
        
        enableOfButtons(start: true, pause: false, restart: false)
        isUserInteractionEnabled(yes: true)
        addVibration()
        
        audioPlayer.stop()
    }
}
