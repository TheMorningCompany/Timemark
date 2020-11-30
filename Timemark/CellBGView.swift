//
//  CellBGView.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 11/29/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class CellBGView: UIView {

    
    override func awakeFromNib() {
        layer.cornerRadius = 20.0
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
    }

}
