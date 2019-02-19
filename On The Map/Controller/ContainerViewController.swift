//
//  ContainerViewController.swift
//  On The Map
//
//  Created by Zeyad AlHusainan on 19/02/2019.
//  Copyright © 2019 Zeyad. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var locationsData: LocationsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadStudentLocations()
    }
    
    func setupUI() {
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addLocationTapped(_:)))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshLocationsTapped(_:)))
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logoutTapped(_:)))
        
        navigationItem.rightBarButtonItems = [plusButton, refreshButton]
        navigationItem.leftBarButtonItem = logoutButton
    }
    
    @objc private func addLocationTapped(_ sender: Any) {
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddLocationNavigationController") as! UINavigationController
        
        present(navController, animated: true, completion: nil)
    }
    
    @objc private func refreshLocationsTapped(_ sender: Any) {
        loadStudentLocations()
    }
    
    @objc private func logoutTapped(_ sender: Any) {
        // Here you should call the corresponding API for deleting the session, and you should go back to Login screen on success
        print("Logout not implemented yet")
    }
    
    private func loadStudentLocations() {
        API.Parser.getStudentLocations { (data) in
            guard let data = data else {
                self.showAlert(title: "Error", message: "No internet connection found")
                return
            }
            guard data.studentLocations.count > 0 else {
                self.showAlert(title: "Error", message: "No pins found")
                return
            }
            self.locationsData = data
        }
    }
    
}
