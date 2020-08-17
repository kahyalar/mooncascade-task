//
//  ListVC+Views.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 15.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit
import Contacts

class ListVCViews: View {
    weak var viewController: ListVC!
    var positions: [String] = []
    var contacts: [CNContact] = []
    var employees: [Employee] = []
    var dataSource: [Employee] = [] {
        didSet {
            noNetworkLabel.isHidden = dataSource.count != 0
        }
    }
    lazy var refreshControl = UIRefreshControl()
    lazy var collectionView = UICollectionView(orientation: .vertical)
    lazy var noNetworkLabel: MCLabel = {
        let label = MCLabel(weight: .bold, size: 50.0)
        label.text = "👻"
        label.sizeToFit()
        label.isHidden = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func layoutViews() {
        super.layoutViews()
        prepareCollectionView()
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(noNetworkLabel)
        NSLayoutConstraint.activate([
            noNetworkLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noNetworkLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc private func refreshList() {
        noNetworkLabel.isHidden = true
        indicator.startAnimating()
        viewController.fetchContacts()
        viewController.fetchEmployees()
        indicator.stopAnimating()
        refreshControl.endRefreshing()
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGray6
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(ListViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
    }
    
    private func getContact(for employee: Employee) -> CNContact? {
        return contacts.filter({"\($0.givenName) \($0.familyName)" == employee.fullname}).first
    }
}

extension ListVCViews: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return positions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.filter({$0.position == positions[section]}).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ListViewCell
        var employee = dataSource.filter({$0.position == positions[indexPath.section]}).sorted(by: { $0.lastname < $1.lastname })[indexPath.row]
        employee.nativeContact = getContact(for: employee)
        cell.viewController = viewController
        cell.configureCell(for: employee)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height * 0.075)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! ListViewHeader
        header.backgroundColor = .systemGray6
        header.title.text = positions[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: width, height: height * 0.075)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ListViewCell
        let detailPage: DetailVC = {
            let detailPage = DetailVC()
            detailPage.employee = cell.employee
            return detailPage
        }()
        DispatchQueue.main.async {
            self.viewController.navigationController?.pushViewController(detailPage, animated: true)
        }
    }
}
