//
//  NCError.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 14.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
    case urlError = "Site is not reachable. Please try again later!"
    case taskError = "Fetching failed. Please check your internet connectivity!"
    case dataError = "Whoops! Something went wrong, please try again!"
}
