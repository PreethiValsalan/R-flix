//
//  LoginController.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/18/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class LoginController: UIViewController {
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       indicator.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let _username =  userTextField.text //"PreethiValsalan"
        let _password = passwordText.text // "movie123*"
        if _username == "" || _password == "" {
            let alert = UIAlertController(title: "UserName/Password", message: "Please enter values", preferredStyle: .alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        indicator.startAnimating()
        let loginHandler: (JSON?, NetworkError)->Void = { (data, networkError) in
            if(data!["success"].boolValue) {
                self.indicator.stopAnimating()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarControllerID") as! UITabBarController
                self.present(vc, animated: true, completion: nil)
                
            } else {
                self.indicator.stopAnimating()
                print("Error LoginController")
            }
            
        }
        UCProvider.INSTANCE.getSessionUC().authenticate(username: _username!, password: _password!, completionHandler: loginHandler)
    
    }
    
}
