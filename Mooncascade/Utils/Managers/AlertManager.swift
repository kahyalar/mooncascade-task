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
    
    func alert(for error: MCError) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    func alert(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}
