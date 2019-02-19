//
//  LoginViewController.swift
//  On The Map
//
//  Created by Zeyad AlHusainan on 19/02/2019.
//  Copyright © 2019 Zeyad. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotificationsObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromNotificationsObserver()
    }
    
    private func setupUI() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if (email!.isEmpty) || (password!.isEmpty) {
            self.showAlert(title: "Fill the required fields", message: "Please fill both the email and password")
            
        } else {
            API.postSession(username: emailTextField.text!, password: passwordTextField.text!) { (errString) in
                guard errString == nil else {
                    self.showAlert(title: "Error", message: errString!)
                    return
                }
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "Login", sender: nil)
                }
            }
        }
        
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        if let url = URL(string: "https://www.udacity.com/account/auth#!/signup"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    

}
