//
//  TimerStore.swift
//  Timebox
//
//  Created by Ehren Murdick on 4/11/16.
//  Copyright © 2016 Ehren Murdick. All rights reserved.
//

import UIKit

class TimerStore {
    var timers: [Timer]
    
    var count: Int {
        return timers.count
    }
    
    init() {
        timers = TimerStore.getSavedTimers()
    }
    
    func inRange(index: Int) -> Bool {
        return index < timers.endIndex
    }
    
    func append() {
        timers.append(Timer.empty())
        saveTimers()
    }
    
    func get(index: Int) -> Timer {
        return self.timers[index]
    }
    
    func toggle(index: Int) {
        let timer = timers[index].toggle()
        timers = timers.map {
            (timer) -> Timer in
            return timer.stop()
        }
        timers[index] = timer
        
        saveTimers()
    }
    
    func delete(index: Int) {
        timers.removeAtIndex(index)
        saveTimers()
    }
    
    func rename(index: Int, newName: String) {
        timers[index] = timers[index].rename(newName)
        saveTimers()
    }
    
    //    MARK: - Persistence

    class func getSavedTimers() -> [Timer] {
        guard let data = NSUserDefaults.standardUserDefaults().objectForKey("timers") as? NSData
            else { return [] }
        
        guard let timers = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Timer]
            else { return [] }
        
        
        return timers
    }
    
    func saveTimers() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(timers)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "timers")
    }

}
