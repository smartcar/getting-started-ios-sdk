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
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let clientId = "29123987-3302-4145-8422-5bfff70b7d89"
        
        appDelegate.smartcar = SmartcarAuth(clientId: clientId, redirectUri: "sc" + clientId + "://page", development: true, completion: completion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectPressed(_ sender: UIButton) {
        let smartcar = appDelegate.smartcar!
        smartcar.launchAuthFlow(viewController: self)
    }
    
    func completion(err: Error?, code: String?, state: String?) -> Any {
        // send request to retrieve
        Alamofire.request("http://localhost:8000/callback?code=" + code!, method: .get).responseJSON {_ in
            Alamofire.request("http://localhost:8000/vehicle", method: .get).responseJSON { response in
                print(response.result.value!)
            
                self.viewDidAppear(_: true)
            }
        }
        
        return ""
    }

}

