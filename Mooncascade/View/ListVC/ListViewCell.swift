//
//  ListViewCell.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 15.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit
class ListViewCell: Cell {
    var employee: Employee!
    weak var viewController: ListVC!
    
    // MARK: - Create UI components
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .regular)
        return label
    }()
    lazy var detailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.tintColor = .systemBlue
        button.setTitle("✅", for: .normal)
        button.addTarget(self, action: #selector(showNativePage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Layout UI components
    override func layoutViews() {
        super.layoutViews()
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: width * 0.05)
        ])
        
        addSubview(detailsButton)
        NSLayoutConstraint.activate([
            detailsButton.topAnchor.constraint(equalTo: topAnchor),
            detailsButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            detailsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            detailsButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsButton.widthAnchor.constraint(equalToConstant: width * 0.15)
        ])
    }
    
    // MARK: - Configure UI components
    func configureCell(for employee: Employee) {
        self.employee = employee
        nameLabel.text = employee.fullname
        detailsButton.isHidden = employee.nativeContact != nil ? false : true
    }
    
    @objc func showNativePage() {
        ContactsManager.shared.showContactPage(for: employee.nativeContact, from: viewController)
    }
}
