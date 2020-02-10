//
//  SecondViewController.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/7/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {
    
    
    var time = Timer()
    
    let clock = Clock()
    
    @IBOutlet weak var setTime: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DateandTime), userInfo: nil, repeats: true)
    }

    @objc func DateandTime () {
        let time = DateFormatter()
       let date = DateFormatter()
        
        time.timeStyle = .short
        date.dateStyle = .medium
        
        setTime.text = time.string(from: Date())
        
        dateLabel.text = date.string(from: Date())
        
    }
    
    
    
    

}

