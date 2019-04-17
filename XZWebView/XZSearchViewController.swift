//
//  XZSearchViewController.swift
//  XZWebView
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class XZSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: XZSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.throttlingInterval = 10
    }
    
    @IBAction func dissmissController(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
