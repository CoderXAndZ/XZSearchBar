//
//  XZDisptachWorkItem.swift
//  XZWebView
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class XZDebounce {
    
    let label: String
    let interval: DispatchTimeInterval
    fileprivate let queue: DispatchQueue
    fileprivate let semaphore: XZDispatchSemaphore
    fileprivate var workItem: DispatchWorkItem?
    
    init(label: String, interval: Float, qos: DispatchQoS = .userInteractive) {
        
        self.interval  = .milliseconds(Int(interval * 1000))
        self.label = label
        self.queue = DispatchQueue(label: "com.farfetch.debouncer.internalqueue.\(label)", qos: qos)
        
        self.semaphore = XZDispatchSemaphore(withValue: 1)
    }
    
    public func call(_ callback: @escaping (() -> ())) {
        
        self.semaphore.sync  { () -> () in
          
            self.workItem?.cancel()
            
            self.workItem = DispatchWorkItem {
                callback()
            }
            
            if let workItem = self.workItem {
                
                self.queue.asyncAfter(deadline: .now() + self.interval, execute: workItem)
            }
        }
    }
    
}

struct XZDispatchSemaphore {
    
    private let semaphore: DispatchSemaphore
    
    public init(withValue value: Int) {
        
        self.semaphore = DispatchSemaphore(value: value)
    }
    
    public func sync<T>(execute: () throws -> T) rethrows -> T {
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        defer { semaphore.signal() }
        
        return try execute()
    }
}
