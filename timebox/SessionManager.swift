////
////  SessionManager.swift
////  Timebox
////
////  Created by Ehren Murdick on 4/7/16.
////  Copyright © 2016 Ehren Murdick. All rights reserved.
////
//
//import UIKit
//import WatchConnectivity
//
//class SessionManager: NSObject, WCSessionDelegate {
//    static let sharedManager = SessionManager()
//    
//    private let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
//    
//    private var validSession: WCSession? {
//        // paired - the user has to have their device paired to the watch
//        // watchAppInstalled - the user must have your watch app installed
//        
//        // Note: if the device is paired, but your watch app is not installed
//        // consider prompting the user to install it for a better experience
//        if let session = session where session.paired && session.watchAppInstalled {
//            return session
//        }
//        return nil
//    }
//    
//    // Live messaging! App has to be reachable
//    private var validReachableSession: WCSession? {
//        // check for validSession on iOS only (see above)
//        // in your Watch App, you can just do an if session.reachable check
//        if let session = validSession where session.reachable {
//            return session
//        }
//        return nil
//    }
//
//    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
//        print("recv message", message)
//        replyHandler(["reply": "handler"])
//    }
//    
//    func startSession() {
//        session?.delegate = self
//        session?.activateSession()
//    }
//}
