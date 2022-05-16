//
//  Decoration.swift
//  DreamCity
//
//  Created by 1 on 09.05.2022.
//

import UIKit

enum Decoration: String, CaseIterable {
    case build1
    case build2
    case build3
    case build4
    case build5
    case build6
    
    var image: String {
        switch self {
        case .build1:
            return "decoration-1"
        case .build2:
            return "decoration-2"
        case .build3:
            return "decoration-3"
        case .build4:
            return "decoration-4"
        case .build5:
            return "decoration-5"
        case .build6:
            return "decoration-6"
        }
    }
}
