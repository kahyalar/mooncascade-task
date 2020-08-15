//
//  UICollectionView.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 15.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

extension UICollectionView {
    convenience init(orientation: UICollectionView.ScrollDirection) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = orientation
        self.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = .white
        self.isScrollEnabled = true
    }
}
