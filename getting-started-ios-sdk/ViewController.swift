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
        
        appDelegate.smartcar = SmartcarAuth(
            clientId: Constants.clientId,
            redirectUri: "sc\(Constants.clientId)://exchange",
            development: true,
            completion: completion
        )
        
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
        let smartcar = appDelegate.smartcar!
        smartcar.launchAuthFlow(viewController: self)
    }
    
    func completion(err: Error?, code: String?, state: String?) -> Any {
        // send request to exchange auth code for access token
        Alamofire.request("\(Constants.appServer)/exchange?code=\(code!)", method: .get).responseJSON {_ in
            
            // send request to retrieve the vehicle info
            Alamofire.request("\(Constants.appServer)/vehicle", method: .get).responseJSON { response in
                print(response.result.value!)
                
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    
                    let make = JSON.object(forKey: "make")!  as! String
                    let model = JSON.object(forKey: "model")!  as! String
                    let year = String(JSON.object(forKey: "year")!  as! Int)
                    
                    let vehicle = "\(year) \(make) \(model)"
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

