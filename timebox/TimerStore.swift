//
//  TimerStore.swift
//  Timebox
//
//  Created by Ehren Murdick on 4/7/16.
//  Copyright © 2016 Ehren Murdick. All rights reserved.
//

import UIKit

class TimerStore {
    static var sharedStore = TimerStore()
    var timers: [Timer] = []
    
    var count: Int {
        return timers.count
    }
    
    func toggleTimer(index: Int) {
        let timer = timers[index].toggle()
        timers = timers.map {
            (timer) -> Timer in
            return timer.stop()
        }
        timers[index] = timer
    }
    
    func deleteAtIndex(index: Int) {
        guard index < timers.endIndex else { return }
        timers.removeAtIndex(index)
    }
    
    func appendNewTimer() {
        timers.append(Timer.empty())
    }
    
    func timerAtIndex(index: Int) -> Timer? {
        guard index < timers.endIndex else { return nil }
        return timers[index]
    }
    
    func updateTimerAtIndex(index: Int, newTimer: Timer) {
        guard index < timers.endIndex else { return }
        timers[index] = newTimer
    }
}
