import UIKit

struct Timer {
    var startTime: NSDate?
    var savedDuration: NSTimeInterval
    
    var isActive: Bool {
        return startTime != nil
    }
    
    var prompt: String {
        if isActive {
            return "Stop"
        } else {
            return "Start"
        }
    }
    
    var currentElapsed: NSTimeInterval {
        guard let t = startTime else {
            return 0
        }
        
        let currentTime = NSDate()
        return currentTime.timeIntervalSinceDate(t)
    }
    
    var duration: NSTimeInterval {
        return currentElapsed + savedDuration
    }
    
    init() {
        savedDuration = 0
    }
    
    init(startTime: NSDate?, duration: NSTimeInterval) {
        self.startTime = startTime
        self.savedDuration = duration
    }
    
    func toggle() -> Timer {
        if isActive {
            return stop()
        } else {
            return start()
        }
    }
    
    func start() -> Timer {
        guard self.startTime == nil
            else { return self }
        
        return Timer(startTime: NSDate(), duration: savedDuration)
    }
    
    func stop() -> Timer {
        return Timer(startTime: nil, duration: duration)
    }
}
