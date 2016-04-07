//
//  TimerCell.swift
//  timebox
//
//  Created by Ehren Murdick on 4/6/16.
//  Copyright © 2016 Ehren Murdick. All rights reserved.
//

import UIKit

class TimerCell: UITableViewCell {
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var toggleButton: UIButton!
    
    @IBOutlet var dateFormatter: NSDateComponentsFormatter!
    
    func configureWithTimer(timer: Timer, tag: Int) {
        durationLabel.text = dateFormatter.stringFromTimeInterval(timer.duration)
        
        nameLabel.text = "A timer"
        toggleButton.setTitle(timer.prompt, forState: .Normal)
        toggleButton.tag = tag
    }
}
