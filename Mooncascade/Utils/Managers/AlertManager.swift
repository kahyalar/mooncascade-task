//
//  AlertManager.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 16.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

class AlertManager {
    private init(){}
    static let shared = AlertManager()
    
    /// Creates custom alert message from MCError value
    /// - Parameter error: Error value to create alert from
    /// - Returns: Custom created UIAlertViewController to display
    func alert(for error: MCError) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    /// Creates custom alert message from message value
    /// - Parameter message: Message value to create alert from
    /// - Returns: Custom created UIAlertViewController to display
    func alert(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}
