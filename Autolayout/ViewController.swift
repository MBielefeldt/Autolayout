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
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI()
    {
        passwordTextField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        image = loggedInUser?.image
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
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
    
    var image: UIImage? {
        get {
            return logoImage.image
        }
        set {
            logoImage.image = newValue
            if let constrainedView = logoImage {
                if let newImage = newValue {
                    logoAspectRatioConstraint = NSLayoutConstraint(item: constrainedView,
                                                              attribute: .Width,
                                                              relatedBy: .Equal,
                                                                 toItem: constrainedView,
                                                              attribute: .Height,
                                                             multiplier: newImage.aspectRatio,
                                                               constant: 0)
                }
                else {
                    logoAspectRatioConstraint = nil
                }
            }
        }
    }

    var logoAspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let existingConstraint = logoAspectRatioConstraint {
                logoImage.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint = logoAspectRatioConstraint {
                logoImage.addConstraint(newConstraint)
            }
        }
    }
}

extension User
{
    var image: UIImage? {
        if let image = UIImage(named: login) {
            return image
        }
        else {
            return UIImage(named: "unknown_user")
        }
    }
}

extension UIImage
{
    var aspectRatio: CGFloat {
        return size.height != 0 ? (size.width / size.height) : 0
    }
}

