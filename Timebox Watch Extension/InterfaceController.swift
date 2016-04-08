//
//  InterfaceController.swift
//  Timebox Watch Extension
//
//  Created by Ehren Murdick on 4/7/16.
//  Copyright © 2016 Ehren Murdick. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    @IBOutlet var table: WKInterfaceTable!
    
    var session: WCSession!
    
    var runningColor: UIColor! = UIColor ( red: 0.1804, green: 0.8, blue: 0.4431, alpha: 1.0 )
    var stoppedColor: UIColor! = UIColor ( red: 0.9059, green: 0.298, blue: 0.2353, alpha: 1.0 )
    
    var timers: [Timer] = [
        Timer(startTime: nil, savedDuration: 0, name: "Quit it"),
        Timer(startTime: nil, savedDuration: 0, name: "Don do"),
    ]

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        session = WCSession.defaultSession()
        
        session.delegate = self
        session.activateSession()
        
        session.sendMessage(["getTimers" : "all"], replyHandler: {
            [weak self, weak table, timers](response: [String : AnyObject]) in
            table?.setNumberOfRows(timers.count, withRowType: "timerRow")
            self?.syncAllTimers()
        }) { (error: NSError) in
            print(error)
        }
    }
    
    
    func syncAllTimers() {
        timers.enumerate().forEach { (index: Int, timer: Timer) in
            guard let row = table.rowControllerAtIndex(index) as? Row else { return }
            row.label.setText(timer.name)
            row.wktimer.setDate(timer.apparentStartDate)
            if (timer.isActive) {
                row.wktimer.start()
                row.label.setTextColor(runningColor)
            } else {
                row.wktimer.stop()
                row.label.setTextColor(stoppedColor)
            }
        }
    }
    
    func stopAllTimers() {
        timers = timers.map { (t: Timer) -> Timer in
            return t.stop()
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        guard rowIndex < timers.endIndex else { return }
        let timer = timers[rowIndex].toggle()
        stopAllTimers()
        timers[rowIndex] = timer
        syncAllTimers()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
