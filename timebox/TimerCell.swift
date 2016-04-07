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
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var toggleButton: UIButton!
    
    @IBOutlet var dateFormatter: NSDateComponentsFormatter!
    
    var nstimer: NSTimer?
    var timer: Timer!
    
    func configureWithTimer(timer: Timer, tag: Int) {
        nstimer?.invalidate()
        durationLabel.text = dateFormatter.stringFromTimeInterval(timer.duration)
        
        nameTextField.text = timer.name
        toggleButton.setTitle(timer.prompt, forState: .Normal)
        toggleButton.tag = tag
        nameTextField.tag = tag
        
        self.timer = timer
        
        if timer.isActive {
            nstimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                                                             target: self,
                                                             selector: #selector(updateCurrentTime),
                                                             userInfo: nil,
                                                             repeats: true)
        }
    }
    
    func updateCurrentTime() {
        durationLabel.text = dateFormatter.stringFromTimeInterval(timer.duration)
    }
    
    override func prepareForReuse() {
        nstimer?.invalidate()
    }
}
