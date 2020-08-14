//
//  ViewController.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 14.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    var employees: [Employee] = [] {
        didSet {
            employees = employees.removingDuplicates()
            employees.sort { (lhs, rhs) -> Bool in
                lhs.lastname < rhs.lastname
            }
            for employee in employees {
                print(employee.lastname)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmployees()
    }
    
    func fetchEmployees(){
        let endpoints: [Endpoint] = [.tallinn, .tartu]
        for endpoint in endpoints {
            NetworkManager.shared.getEmployees(for: endpoint) { result in
                switch result {
                case .success(let fetchedEmployees):
                    self.employees.append(contentsOf: fetchedEmployees)
                case .failure(let error):
                    print(error.rawValue)
                }
            }
        }
    }

}

