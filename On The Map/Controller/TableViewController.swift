//
//  TableViewController.swift
//  On The Map
//
//  Created by Zeyad AlHusainan on 20/02/2019.
//  Copyright © 2019 Zeyad. All rights reserved.
//

import UIKit

class TableViewController: ContainerViewController {


    @IBOutlet var tableView: UITableView!
    override var locationsData: LocationsData? {
        didSet {
            guard let locationsData = locationsData else { return }
            locations = locationsData.studentLocations
        }
    }
    var locations: [StudentLocation] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
}


extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell")!
        let location = self.locations[(indexPath as NSIndexPath).row]

        cell.textLabel?.text = location.firstName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = self.locations[(indexPath as NSIndexPath).row]
        if let url = URL(string: location.mediaURL!),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
