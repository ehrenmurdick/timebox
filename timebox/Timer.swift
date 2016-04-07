import UIKit

struct Timer {
    var startTime: NSDate?
    var savedDuration: NSTimeInterval
    
    var name: String
    
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
    
    static func empty() -> Timer {
        return Timer(startTime: nil, savedDuration: 0, name: "")
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
        
        return Timer(startTime: NSDate(), savedDuration: savedDuration, name: name)
    }
    
    func stop() -> Timer {
        return Timer(startTime: nil, savedDuration: duration, name: name)
    }
    
    func rename(name: String) -> Timer {
        return Timer(startTime: startTime, savedDuration: duration, name: name)
    }
}
