//
//  NCError.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 14.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import Foundation

enum MCError: String, Error {
    case urlNotReachable = "Site is not reachable. Please try again later!"
    case fetchingFailed = "Fetching failed. Please check your internet connectivity!"
    case systemError = "Whoops! Something went wrong, please try again!"
    case cacheNotFound = "Cache is not found!"
    case contactsPermissionDenied = "For the full experience please allow to access contacts. (Settings -> Mooncascade -> Contacts)"
}
