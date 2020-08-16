//
//  ListViewCell.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 15.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

class ListViewCell: Cell {
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
        button.tintColor = .systemBlue
        button.setTitle(">>", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
            detailsButton.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -width * 0.05)
        ])
    }
    
    func configureCell(for employee: Employee) {
        nameLabel.text = employee.fullname
    }
}
