//
//  MetronomeViewController.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/11/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class MetronomeViewController: UIViewController {

    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let sliderValue = round(sender.value)
        bpmLabel.text = String(sliderValue) + " bpm"
    }
}
