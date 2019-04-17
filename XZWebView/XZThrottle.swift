//
//  XZThrottle.swift
//  XZWebView
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class XZThrottle {
    
    private let queue: DispatchQueue = DispatchQueue.global(qos: .background)
    
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private var maxInterval: Int
    
    fileprivate let semaphore: XZDispatchSemaphore
    
    init(seconds: Int) {
        self.maxInterval = seconds
        self.semaphore = XZDispatchSemaphore(withValue: 1)
    }
    
    func throttle(block: @escaping () -> ()) {
        
        self.semaphore.sync  { () -> () in
            job.cancel()
            job = DispatchWorkItem(){ [weak self] in
                self?.previousRun = Date()
                block()
            }
            let delay = Date.second(from: previousRun) > maxInterval ? 0 : maxInterval
            queue.asyncAfter(deadline: .now() + Double(delay), execute: job)
        }
        
    }
}

private extension Date {
    
    static func second(from referenceDate: Date) -> Int {
        
        return Int(Date().timeIntervalSince(referenceDate).rounded())
    }
    
}
