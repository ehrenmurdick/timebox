import UIKit

struct Timer {
    var startTime: NSDate?
    var duration: Double
    
    var isActive: Bool {
        return startTime != nil
    }
    
    init() {
        duration = 0
    }
    
    init(startTime: NSDate?, duration: Double) {
        self.startTime = startTime
        self.duration = duration
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
        
        return Timer(startTime: NSDate(), duration: duration)
    }
    
    func stop() -> Timer {
        guard let startTime = self.startTime
            else { return self }
        
        let currentTime = NSDate()
        let diff = currentTime.timeIntervalSinceDate(startTime)
        let newDuration = duration + diff
        
        return Timer(startTime: nil, duration: newDuration)
    }
}
