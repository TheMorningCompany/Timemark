//
//  ClockFaceViewController.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 6/22/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class ClockFaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerSettingsBundle()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func diskFacePressed() {
        setClockFace(face: "disk")
    }
    
    @IBAction func insetFacePressed() {
        setClockFace(face: "inset")
    }
    
    @IBAction func ornamentalFacePressed() {
        setClockFace(face: "ornamental")
    }
    
    @IBAction func californiaFacePressed() {
        setClockFace(face: "california")
    }
    
    func setClockFace(face: String) {
        print(face)
        print(UserDefaults.standard.string(forKey: "clock_face")!)
        UserDefaults.standard.set(face, forKey: "clock_face")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .didChangeClockFace, object: nil)
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
