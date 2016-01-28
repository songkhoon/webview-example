//
//  LocalStorageTest.swift
//  WebviewExample
//
//  Created by jeff on 27/01/2016.
//  Copyright © 2016 jeff. All rights reserved.
//

import UIKit
import WebKit

class LocalStorageTest : UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var screenLabel: UILabel!
    
    var theWebView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(URL: NSURL(string:"https://arty.name/localstorage.html")!)
        
        theWebView = WKWebView(frame: self.view.frame)
        theWebView.loadRequest(request)
        self.view.insertSubview(theWebView, atIndex: 0)
        
    }
    
}