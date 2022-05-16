//
//  ViewController.swift
//  DreamCity
//
//  Created by 1 on 05.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var gameViewController: UIViewController!
    
    @IBOutlet var buttons: [UIButton]! {
        didSet {
            for btn in buttons {
                btn.backgroundColor = UIColor(red: 0.70, green: 0.33, blue: 0.31, alpha: 1.00)
                btn.layer.cornerRadius = 10
                btn.layer.borderColor = UIColor.white.cgColor
                btn.layer.borderWidth = 2
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.74, green: 0.56, blue: 0.16, alpha: 1.00)
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController")
        AudioPlayer.shared.setupMusic()
        if Application.shared.music {
            AudioPlayer.shared.playMusic()
            
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        if Application.shared.music {
            AudioPlayer.shared.setSound(sound: .hammerBlow)
            AudioPlayer.shared.playSound()
        }
    }
}

