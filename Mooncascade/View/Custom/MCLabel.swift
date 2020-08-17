//
//  MCLabel.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 16.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

class MCLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.sizeToFit()
        self.numberOfLines = 2
        self.textColor = .black
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Custom initializer for the label with weight and size parameters.
    /// - Parameters:
    ///   - weight: Weight parameter of the label
    ///   - size: Size parameter of the label
    convenience init(weight: UIFont.Weight, size: CGFloat? = 0) {
        self.init()
        self.font = UIFont.systemFont(ofSize: self.font.pointSize + size!, weight: weight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
