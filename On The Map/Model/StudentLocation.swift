//
//  StudentLocation.swift
//  On The Map
//
//  Created by Zeyad AlHusainan on 19/02/2019.
//  Copyright © 2019 Zeyad. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    var createdAt: String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var uniqueKey: String?
    var updatedAt: String?
}

extension StudentLocation {
    init(mapString: String, mediaURL: String) {
        self.mapString = mapString
        self.mediaURL = mediaURL
    }
}

enum SLParam: String {
    case createdAt
    case firstName = "first_name"
    case lastName = "last_name"
    case latitude
    case longitude
    case mapString
    case mediaURL
    case objectId
    case uniqueKey
    case updatedAt
}
