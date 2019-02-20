//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by Zeyad AlHusainan on 20/02/2019.
//  Copyright © 2019 Zeyad. All rights reserved.
//

import UIKit
import CoreLocation


class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var mediaLinkTextField: UITextField!
    
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

    @IBAction func findLocationButton(_ sender: Any) {
        guard let location = locationTextField.text,
            let mediaLink = mediaLinkTextField.text,
            location != "", mediaLink != "" else {
                self.showAlert(title: "Missing information", message: "Please fill both fields and try again")
                return
        }
        
        let studentLocation = StudentLocation(mapString: location, mediaURL: mediaLink)
        geocodeCoordinates(studentLocation)
    }
    
    private func geocodeCoordinates(_ studentLocation: StudentLocation) {
        
        let ai = self.startAnActivityIndicator()
        // TODO: Use CLGeocoder's function named `geocodeAddressString` to convert location's `mapString` to coordinates
        CLGeocoder().geocodeAddressString(studentLocation.mapString!) { (placeMarks, err) in
            // TODO: Call `ai.stopAnimating()` first thing in the completionHandler
            ai.stopAnimating()
            // TODO: Extract the first location from Place Marks array
            guard let firstLocation = placeMarks?.first?.location else { return }
            // TODO: Copy studentLocation into a new object and save latitude and longitude in the new object's properties `latitude` and `longitude`
            var location = studentLocation
            location.latitude = firstLocation.coordinate.latitude
            location.longitude = firstLocation.coordinate.longitude
            // TODO: Call performSegue using `mapSegue` identifier and pass `location` as the sender
            self.performSegue(withIdentifier: "mapSegue", sender: location)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue", let vc = segue.destination as? ConfirmLocationViewController {
            vc.location = (sender as! StudentLocation)
        }
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.cancelTapped(_:)))
        
        locationTextField.delegate = self
        mediaLinkTextField.delegate = self
    }
    
    @objc private func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


