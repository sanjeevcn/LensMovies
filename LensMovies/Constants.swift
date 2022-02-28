//
//  Constants.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import Foundation
import SwiftUI

struct Constants {
    static var containerName = "LensMovies"
    static var appName = "Lens Movies"
    static var appDescription = ""
}

extension CGFloat {
    static var deviceHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    static var deviceWidth: CGFloat {
        UIScreen.main.bounds.width
    }
}
