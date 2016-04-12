import UIKit

class Timer: NSObject, NSCoding {
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
    
    init(startTime: NSDate?, savedDuration: NSTimeInterval, name: String) {
        self.startTime = startTime
        self.savedDuration = savedDuration
        self.name = name
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
    
// MARK: - NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObjectForKey("name") as? String
            else { return nil }
        
        let savedDuration = decoder.decodeDoubleForKey("savedDuration") as NSTimeInterval
        let startTime = decoder.decodeObjectForKey("startTime") as? NSDate
        
        self.init(
            startTime: startTime,
            savedDuration:  savedDuration,
            name: name
        )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(startTime, forKey: "startTime")
        aCoder.encodeDouble(savedDuration, forKey: "savedDuration")
    }
}
