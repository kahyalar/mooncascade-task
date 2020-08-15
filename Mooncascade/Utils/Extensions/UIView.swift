//
//  UIView.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 15.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

extension UIView {
    convenience init(color: UIColor? = .white) {
        self.init()
        self.backgroundColor = color
    }

    public var height: CGFloat {
        get { return frame.size.height }
    }
    public var width: CGFloat {
        get { return frame.size.width }
    }
}
