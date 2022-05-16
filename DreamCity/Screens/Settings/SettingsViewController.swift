//
//  SettingsViewController.swift
//  DreamCity
//
//  Created by 1 on 09.05.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var deleteCityButton: UIButton! {
        didSet {
            deleteCityButton.layer.cornerRadius = deleteCityButton.frame.height/2
            deleteCityButton.layer.borderWidth = 1
            deleteCityButton.layer.borderColor = UIColor.white.cgColor
            deleteCityButton.backgroundColor = UIColor(red: 0.70, green: 0.33, blue: 0.31, alpha: 1.00)
            deleteCityButton.tintColor = .white
        }
    }
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.layer.cornerRadius = 20
            closeButton.layer.borderWidth = 2
            closeButton.layer.borderColor = UIColor.white.cgColor
            closeButton.backgroundColor = UIColor(red: 0.70, green: 0.33, blue: 0.31, alpha: 1.00)
            closeButton.tintColor = .white
        }
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.layer.cornerRadius = 20
            backgroundImageView.layer.borderWidth = 2
            backgroundImageView.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @IBOutlet weak var musicSwitch: UISwitch! {
        didSet {
            musicSwitch.isOn = Application.shared.music
        }
    }
    
    @IBOutlet weak var soundEffectsSwitch: UISwitch! {
        didSet {
            soundEffectsSwitch.isOn = Application.shared.sound
        }
    }
    
    @IBOutlet weak var bordersSwitch: UISwitch! {
        didSet {
            bordersSwitch.isOn = Application.shared.borders
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Application.shared.music)
    }
    
    @IBAction func musicSwitch(_ sender: Any) {
        Application.shared.music = musicSwitch.isOn
        if Application.shared.music {
            AudioPlayer.shared.playMusic()
        } else {
            AudioPlayer.shared.stopMusic()
        }
    }
    
    @IBAction func soundEffectsSwitch(_ sender: Any) {
        Application.shared.sound = soundEffectsSwitch.isOn
    }
    
    @IBAction func bordersSwitch(_ sender: Any) {
        Application.shared.borders = bordersSwitch.isOn
    }
    
    
    @IBAction func deleteCityButton(_ sender: Any) {
        if Application.shared.music {
        AudioPlayer.shared.setSound(sound: .hammerBlow)
        AudioPlayer.shared.playSound()
        }
        Application.shared.sectors = [:]
    }
    
    @IBAction func closeButton(_ sender: Any) {
        if Application.shared.music {
        AudioPlayer.shared.setSound(sound: .hammerBlow)
        AudioPlayer.shared.playSound()
        }
        self.dismiss(animated: true)
    }
}

