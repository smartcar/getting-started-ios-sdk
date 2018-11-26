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
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let clientId = "[yourClientId]"
        
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
        // send request to exchange auth code for access token
        Alamofire.request("http://localhost:8000/callback?code=" + code!, method: .get).responseJSON {_ in
            
            // send request to retrieve the vehicle info
            Alamofire.request("http://localhost:8000/vehicle", method: .get).responseJSON { response in
                self.button.removeFromSuperview()
                print(response.result.value!)
                
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    
                    let make = JSON.object(forKey: "make")!  as! String
                    let model = JSON.object(forKey: "model")!  as! String
                    let year = String(JSON.object(forKey: "year")!  as! Int)
                    
                    let vehicle = year + " " + make + " " + model
                    self.vehicleText = vehicle
                    
                    self.performSegue(withIdentifier: "displayVehicleInfo", sender: self)
                }
            }
        }
        
        return ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? InfoViewController {
            destinationVC.text = self.vehicleText
        }
    }

}

