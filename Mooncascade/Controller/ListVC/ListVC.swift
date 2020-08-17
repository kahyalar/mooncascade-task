//
//  ViewController.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 14.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

class ListVC: ViewController<ListVCViews> {
    lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.viewController = self
        fetchContacts()
        fetchEmployees()
        prepareSearchBar(shouldVisible: false)
    }
    
    @objc func searchContact() {
        prepareSearchBar(shouldVisible: true)
    }
    
    private func prepareSearchBar(shouldVisible: Bool){
        if shouldVisible {
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar
            searchBar.becomeFirstResponder()
            searchBar.showsCancelButton = true
        } else {
            navigationItem.titleView = nil
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchContact))
            navigationItem.rightBarButtonItem?.tintColor = .black
            searchBar.showsCancelButton = false
        }
        
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
                    DispatchQueue.main.async {
                        self.present(AlertManager.shared.alert(for: error), animated: true, completion: nil)
                    }
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.customView.employees = self.customView.employees.removingDuplicates().sorted(by: {$0.lastname < $1.lastname})
            self.customView.positions.append(contentsOf: self.customView.employees.map({$0.position}).removingDuplicates().sorted())
            self.customView.dataSource = self.customView.employees
            DispatchQueue.main.async {
                self.customView.collectionView.reloadData()
                self.customView.indicator.stopAnimating()
            }
        }
    }
    
    func fetchContacts(){
        ContactsManager.shared.requestAccess { (result, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    self.present(AlertManager.shared.alert(for: .contactsPermissionDenied), animated: true, completion: nil)
                }
                
            } else {
                switch result {
                case true:
                    do {
                        try ContactsManager.shared.fetchContacts { (contacts) in
                            self.customView.contacts = contacts
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.present(AlertManager.shared.alert(for: .systemError), animated: true, completion: nil)
                        }
                    }
                case false:
                    DispatchQueue.main.async {
                        self.present(AlertManager.shared.alert(for: .contactsPermissionDenied), animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

// MARK: - UISearchBar's delegate functions
extension ListVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        prepareSearchBar(shouldVisible: false)
        customView.dataSource = customView.employees
        customView.collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            customView.dataSource = customView.employees
        } else {
            let firstnameMatches = customView.employees.filter({$0.firstname.lowercased().contains(searchText.lowercased())})
            let lastnameMatches = customView.employees.filter({$0.lastname.lowercased().contains(searchText.lowercased())})
            let positionMatches = customView.employees.filter({$0.position.lowercased().contains(searchText.lowercased())})
            let emailMatches = customView.employees.filter({$0.contacts.email.lowercased().contains(searchText.lowercased())})
            let projectMatches = customView.employees.filter({$0.projects != nil}).filter({$0.projects!.map({$0.lowercased()}).contains(searchText.lowercased())})
            customView.dataSource.removeAll()
            customView.dataSource.appendMultiple(sources: firstnameMatches, lastnameMatches, positionMatches, emailMatches, projectMatches)
            customView.dataSource.removeDuplicates()
        }
        customView.collectionView.reloadData()
    }
}

