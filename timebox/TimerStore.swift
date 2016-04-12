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
        timers = []
    }
    
    func inRange(index: Int) -> Bool {
        return index < timers.endIndex
    }
    
    func append() {
        self.timers.append(Timer.empty())

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
    }
    
    func delete(index: Int) {
        timers.removeAtIndex(index)
    }
    
    func rename(index: Int, newName: String) {
        timers[index] = timers[index].rename(newName)
    }
}
