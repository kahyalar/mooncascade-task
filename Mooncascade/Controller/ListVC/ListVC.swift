//
//  ViewController.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 14.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

class ListVC: ViewController<ListVCViews> {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmployees()
    }
    
    func fetchEmployees(){
        let group = DispatchGroup()
        let endpoints: [Endpoint] = [.tallinn, .tartu]
        for endpoint in endpoints {
            group.enter()
            NetworkManager.shared.getEmployees(for: endpoint) { result in
                switch result {
                case .success(let employees):
                    self.customView.employees.append(contentsOf: employees)
                case .failure(let error):
                    print(error.rawValue)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.customView.employees = self.customView.employees.removingDuplicates().sorted(by: {$0.lastname < $1.lastname})
            self.customView.positions.append(contentsOf: self.customView.employees.map({$0.position}).removingDuplicates().sorted())
            DispatchQueue.main.async {
                self.customView.collectionView.reloadData()
                self.customView.indicator.stopAnimating()
            }
        }
    }
    

}

