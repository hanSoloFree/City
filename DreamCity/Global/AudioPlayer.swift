//
//  AudioPlayer.swift
//  DreamCity
//
//  Created by 1 on 10.05.2022.
//

import AVFoundation

class AudioPlayer {
    
    static let shared = AudioPlayer()
    
    var audioPlayer: AVAudioPlayer?
    
    func setupMusic() {
        
        let music = Bundle.main.path(forResource: "background-music", ofType: "wav")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music!))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    
    func playMusic() {
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.play()
    }
    
    func stopMusic() {
        audioPlayer?.stop()
    }
    
    func changeVolume(volume: Float) {
        audioPlayer?.volume = volume
    }
    
    
    var soundPlayer: AVAudioPlayer?
    
    
    func setSound(sound: SoundEffect) {
        let file = URL(fileURLWithPath: Bundle.main.path(forResource: sound.rawValue, ofType: sound.fileType)!)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: file)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
            soundPlayer?.play()
        } catch {
            print(error)
        }
    }
    
    func playSound() {
//        soundPlayer?.play()
    }
}

enum SoundEffect: String {
    case construction
    case garden
    case hammerBlow = "hammer-blow"
    
    var fileType: String {
        switch self {
        case .construction:
            return "mp3"
        case .garden, .hammerBlow:
            return "wav"
        }
    }
}
