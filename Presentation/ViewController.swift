//  Statistics.swift
//  MotivationTimer
//  Created by Adam West on 23.05.23.

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var hoursGoneLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet var gifAnimationImage: UIImageView!
    
    @IBOutlet weak var minuteCountPicker: UIPickerView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
   
    var timerLogic: TimerLogic?
    let imageArray = (0...11).map { UIImage(named: "\($0)")!}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateGradient()
        
        timerLogic = TimerLogic(viewController: self)
        self.timerLogic?.enableOfButtons(start: true, pause: false, restart: false)
                
        minuteCountPicker.dataSource = self
        minuteCountPicker.delegate = self
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        timerLogic?.timerStart()
    }
    
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        timerLogic?.timerPause()
    }
    
    @IBAction func restartButtonAction(_ sender: UIButton) {
        timerLogic?.timerRestart()
        }
    }

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == minuteCountPicker {
            return 1
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == minuteCountPicker {
            return 59
        }
    return 59
    }
}
extension ViewController {
    func dateGradient() {
        let colorOne = UIColor(red: 153 / 255, green: 26 / 255, blue: 61 / 255, alpha: 0.2).cgColor
        let colorTwo = UIColor(red: 243 / 255, green: 155 / 255, blue: 51 / 255, alpha: 0.2).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [colorOne, colorTwo]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.view.layer.addSublayer(gradientLayer)
    }
}
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == minuteCountPicker {
            timerLogic?.seconds = 60 * (row + 1)
        }
    }
}

