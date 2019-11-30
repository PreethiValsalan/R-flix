//
//  WebViewController.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/26/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebVC : UIViewController {
    
    var webUrl : String!
    var pageName : String!
    
    private var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: webUrl)!
        webView.load(URLRequest(url: url))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.title =  pageName
    }
    
}
