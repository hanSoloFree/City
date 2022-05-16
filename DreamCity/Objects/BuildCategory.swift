//
//  BuildCategory.swift
//  DreamCity
//
//  Created by 1 on 09.05.2022.
//

import UIKit

enum BuildCategory: String, CaseIterable {
    case house = "House"
    case administration = "Administration"
    case entertainment = "Entertainment"
    case decoration = "Decoration"
    case delete = "Delete"
    
    var image: String {
        switch self {
        case .house:
            return House.build1.image
        case .administration:
            return Administration.build1.image
        case .decoration:
            return Decoration.build1.image
        case .entertainment:
            return Entertainment.build1.image
        case .delete:
            return "destruction"
        }
    }
}
