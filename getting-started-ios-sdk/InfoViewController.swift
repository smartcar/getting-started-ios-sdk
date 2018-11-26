//
//  InfoViewController.swift
//  getting-started-ios-sdk
//
//  Created by Smartcar on 11/19/18.
//  Copyright © 2018 Smartcar. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // display the vehicle info
        let vehicleInfo = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 21))
        vehicleInfo.text = text
        self.view.addSubview(vehicleInfo)
        
    }
    
}

