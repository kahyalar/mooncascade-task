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
    
    override func layoutViews() {
        super.layoutViews()
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: width * 0.05)
        ])
    }
}
