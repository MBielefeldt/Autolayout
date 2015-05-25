//
//  ViewController.swift
//  Autolayout
//
//  Created by Mads Bielefeldt on 25/05/15.
//  Copyright (c) 2015 GN ReSound. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI()
    {
        passwordTextField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
    }
    
    var secure = false {
        didSet {
            updateUI()
        }
    }
    
    @IBAction func changeSecurityButton(sender: AnyObject)
    {
        secure = !secure
    }
    
    var loggedInUser: User? {
        didSet {
            updateUI()
        }
    }
    
    @IBAction func loginButton(sender: AnyObject)
    {
        loggedInUser = User.login(usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}

