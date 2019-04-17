//
//  XZSearchBar.swift
//  XZWebView
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class XZSearchBar: UISearchBar {
    
    /// Throttle engine
    private var throttler: XZThrottle? = nil
    
    /// 时间间隔
    var throttlingInterval: Double? = 0 {
        didSet {
            guard let interval = throttlingInterval else {
                self.throttler = nil
                return
            }
            self.throttler = XZThrottle(seconds: Int(interval))
        }
    }
    
    /// 取消事件
    public var onCancel: (() -> (Void))? = nil
    
    
    /// 开始搜索当输入框发生改变且过了，时间间隔throttlingInterval
    public var onSearch: ((String) -> (Void))? = nil
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: -- UISearchBarDelegate
extension XZSearchBar: UISearchBarDelegate {
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.onCancel?()
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.onSearch?(self.text ?? "")
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let throttler = self.throttler else {
            
            self.onSearch?(searchText)
            return
        }
        
        throttler.throttle {
            DispatchQueue.main.async {
                self.onSearch?(self.text ?? "")
                
                print("======= 开始搜了吗")
            }
        }
    }
}
