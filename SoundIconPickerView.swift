//
//  SoundIconPickerView.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 1/12/21.
//  Copyright © 2021 Zeqe Golomb. All rights reserved.
//

import UIKit

class SoundIconPickerView: UIView {

    //This sets the corner radius for the app icons in the options page for it
    
    override func awakeFromNib() {
        layer.cornerRadius = 14.0
        layer.cornerCurve = .continuous
        
    }
    

}
