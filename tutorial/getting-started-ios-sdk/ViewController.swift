//
//  ViewController.swift
//  getting-started-ios-sdk
//
//  Created by Smartcar on 11/19/18.
//  Copyright © 2018 Smartcar. All rights reserved.
//

import Alamofire
import UIKit
import SmartcarAuth

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var vehicleText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: Step 5: Initialize the Smartcar object
        
        // display a button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.addTarget(self, action: #selector(self.connectPressed(_:)), for: .touchUpInside)
        button.setTitle("Connect your vehicle", for: .normal)
        button.backgroundColor = UIColor.black
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectPressed(_ sender: UIButton) {
        // TODO: Step 6: Launch authorization flow
    }
    
    func completion(err: Error?, code: String?, state: String?) -> Any {
        // TODO: Step 7b: Receive an authorization code
        
        // TODO: Step 8: Obtain an access token
        
        // TODO: Step 9: Get vehicle information
        
        return ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? InfoViewController {
            destinationVC.text = self.vehicleText
        }
    }

}

