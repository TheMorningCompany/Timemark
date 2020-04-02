//
//  OptionsViewController.swift
//  Timemark
//
//  Created by Julian Wright on 2/13/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class OptionsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.layer.borderWidth = 0.50
        self.navigationController!.navigationBar.layer.borderColor = UIColor.clear.cgColor
        self.navigationController?.navigationBar.clipsToBounds = true
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        // Do any additional setup after loading the view.
    }
    @IBAction func `true`(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   

}
