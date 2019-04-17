//
//  ViewController.swift
//  XZWebView
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private var requestWork: XZDebounce = XZDebounce(label: "我测试一下", interval: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        requestWork.call {
            print("===========开始搜索")
        }
    }
    
}
