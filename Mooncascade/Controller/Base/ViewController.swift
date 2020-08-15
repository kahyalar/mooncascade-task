//
//  Base.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 15.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

class ViewController<V: View>: UIViewController {
    var customView: V {
        return view as! V
    }
    
    override func loadView() {
        super.loadView()
        view = V()
    }
}
