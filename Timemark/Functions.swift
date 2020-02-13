//
//  Functions.swift
//  Timemark
//
//  Created by Julian Wright on 2/13/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import Foundation
import UIKit
    
var impact = UIImpactFeedbackGenerator()

func doHaptic() {
    if (UserDefaults.standard.bool(forKey: "enable_haptics")) {
        impact.impactOccurred()
    }
}
