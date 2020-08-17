//
//  ListViewHeader.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 15.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

class ListViewHeader: Header {
    // MARK: - Create UI components
    lazy var title = MCLabel(weight: .bold, size: 2.5)
    
    // MARK: - Layout UI components
    override func layoutViews() {
        super.layoutViews()
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: width * 0.05)
        ])
    }
}
