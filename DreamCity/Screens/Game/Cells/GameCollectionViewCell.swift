//
//  GameCollectionViewCell.swift
//  DreamCity
//
//  Created by 1 on 05.05.2022.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    var sector: Sector? {
        didSet {
            startBuilding()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                scaleItem(isSelected: true)
            }
        }
    }
    
    @IBOutlet weak var floorImageView: UIImageView!
    
    @IBOutlet weak var buildImageView: UIImageView!
    
    @IBOutlet weak var builtWidthConstraint: NSLayoutConstraint!
    
    private func startBuilding() {
        guard let sector = sector else { return }
        if (sector.isBuilding || sector.isDestruction) {
            if Application.shared.sound {
                AudioPlayer.shared.soundPlayer = nil
                AudioPlayer.shared.setSound(sound: .construction)
            }
            buildImageView.image = UIImage(named: "building")
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                if let image = sector.buildName {
                    self.buildImageView.image = UIImage(named: image)
                } else {
                    self.buildImageView.image = nil
                }
                self.sector?.isBuilding = false
                self.sector?.isDestruction = false
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                timer.invalidate()
            }
        } else {
            if let image = sector.buildName {
                self.buildImageView.image = UIImage(named: image)
            }
        }
    }
}

extension UICollectionViewCell {
    
    func scaleItem(isSelected: Bool) {
        self.layer.zPosition = isSelected ? 1 : 0
        UIView.animate(withDuration: 0.3) {
            self.transform = isSelected ? CGAffineTransform(scaleX: 1.1, y: 1.1) : CGAffineTransform(scaleX: 1, y: 1)
            self.layer.zPosition = isSelected ? 1 : 0
        }
    }
}
