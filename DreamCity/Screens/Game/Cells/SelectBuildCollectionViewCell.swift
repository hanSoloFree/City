//
//  SelectBuildCollectionViewCell.swift
//  DreamCity
//
//  Created by 1 on 09.05.2022.
//

import UIKit

class SelectBuildCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var buildNameLabel: UILabel!
    
    @IBOutlet weak var floorImageView: UIImageView!
    
    @IBOutlet weak var buildImageView: UIImageView!
    
    func configureCell() {
        self.layer.cornerRadius = 8
    }
}
