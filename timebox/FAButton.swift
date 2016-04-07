//
//  FAButton.swift
//  timebox
//
//  Created by Ehren Murdick on 4/6/16.
//  Copyright © 2016 Ehren Murdick. All rights reserved.
//

import UIKit

class FAButton: UIButton {

    var faIcon: String = "" {
        didSet {
            titleLabel?.font = UIFont.fontAwesomeOfSize(30)
        }
    }
    
}
