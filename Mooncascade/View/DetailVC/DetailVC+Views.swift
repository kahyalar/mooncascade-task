//
//  DetailVC+Views.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 16.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

class DetailVCViews: View {
    // MARK: - Create UI components
    lazy var fullnameLabel = MCLabel(weight: .bold, size: 2.5)
    lazy var emailLabel = MCLabel(weight: .medium)
    lazy var phoneLabel = MCLabel(weight: .medium)
    lazy var positionLabel = MCLabel(weight: .medium)
    lazy var projectsLabel = MCLabel(weight: .medium)
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailLabel, phoneLabel, positionLabel, projectsLabel])
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = UIScreen.main.bounds.height * 0.025
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var nativeContactButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.setTitle("Show in 'Contacts'", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: fullnameLabel.font.pointSize, weight: .bold)
        return button
    }()
    
    // MARK: - Layout UI components
    override func layoutViews() {
        super.layoutViews()
        
        addSubview(fullnameLabel)
        NSLayoutConstraint.activate([
            fullnameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            fullnameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.025),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.025)
        ])
        
        addSubview(nativeContactButton)
        NSLayoutConstraint.activate([
            nativeContactButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nativeContactButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05)
        ])
    }
    
    // MARK: - Configure UI components
    func configureLabels(for employee: Employee) {
        fullnameLabel.text = employee.fullname
        emailLabel.text = "Email: \(employee.contacts.email)"
        positionLabel.text = "Position: \(employee.position.capitalized)"
        
        guard let phoneNumber = employee.contacts.phone else {
            phoneLabel.isHidden = true
            return
        }
        
        guard let projects = employee.projects else {
            projectsLabel.isHidden = true
            return
        }
        
        phoneLabel.text = "Phone: \(phoneNumber)"
        phoneLabel.text = "Projects: \(projects.joined(separator: " | "))"
    }
}
