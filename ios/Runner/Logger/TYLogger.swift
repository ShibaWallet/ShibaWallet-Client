//
//  TYLogger.swift
//  Runner
//
//  Created by JohnnyCheung on 2021/9/4.
//


class TYLogger {
    
    static func send(data: Any?) {
        guard let _data = data else {
            return
        }
        guard let d = _data as? [String:Any] else {
            return
        }
        if let _ = d["eventType"] as? String,
           let event = d["event"] as? String,
           let args = d["data"] as? [String:Any] {
            sendEvent(event: event, args: args)
        }
    }
    
    static func sendEvent(event: String, args: [String:Any]) {
        MobClick.event(event, attributes: args)
    }
    
    
    
}
