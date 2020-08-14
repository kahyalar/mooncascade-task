//
//  Employee.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 14.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import Foundation

struct Employee: Decodable {
    var firstname: String
    var lastname: String
    var contacts: [ContactInformation]
    var position: String
    var projects: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case firstname = "fname"
        case lastname = "lname"
        case contacts = "contact_details"
        case position = "position"
        case projects = "projects"
    }
}

struct ContactInformation: Decodable {
    var email: String
    var phone: String?
}
