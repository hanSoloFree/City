//
//  Administration.swift
//  DreamCity
//
//  Created by 1 on 09.05.2022.
//

import UIKit

enum Administration: String, CaseIterable {
    case build1
    case build2
    case build3
    case build4
    case build5
    
    var image: String {
        switch self {
        case .build1:
            return "build-2"
        case .build2:
            return "build-2"
        case .build3:
            return "build-2"
        case .build4:
            return "build-2"
        case .build5:
            return "build-2"
        }
    }
}
