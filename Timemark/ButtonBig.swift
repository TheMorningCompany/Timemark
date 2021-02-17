//
//  ButtonBig.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/17/21.
//  Copyright © 2021 Zeqe Golomb. All rights reserved.
//

import UIKit

class ButtonBig: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
    }

}
