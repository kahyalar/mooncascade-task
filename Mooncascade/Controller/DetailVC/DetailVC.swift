//
//  DetailVC.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 16.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import Foundation

class DetailVC: ViewController<DetailVCViews> {
    var employee: Employee!
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.configureLabels(for: employee)
        customView.nativeContactButton.isHidden = employee.nativeContact != nil ? false : true
        customView.nativeContactButton.addTarget(self, action: #selector(showNativePage), for: .touchUpInside)
    }
    
    @objc func showNativePage() {
        ContactsManager.shared.showContactPage(for: employee.nativeContact, from: self)
    }
}
