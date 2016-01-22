//
//  WebviewController.swift
//  WebviewExample
//
//  Created by jeff on 22/01/2016.
//  Copyright © 2016 jeff. All rights reserved.
//

import UIKit
import WebKit

class WebviewController : UIViewController, UIWebViewDelegate, WKScriptMessageHandler {
    
    @IBOutlet weak var screenLabel: UILabel!
    
    var theWebView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filePath = NSBundle.mainBundle().pathForResource("index", ofType: "html", inDirectory: "assets")
        let request = NSURLRequest(URL: NSURL.fileURLWithPath(filePath!))
        
        let theConfiguration = WKWebViewConfiguration()
        theConfiguration.userContentController.addScriptMessageHandler(self, name: "observe")
        
        theWebView = WKWebView(frame: self.view.frame, configuration: theConfiguration)
        theWebView.loadRequest(request)
        self.view.insertSubview(theWebView, atIndex: 0)
        
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        let version = message.body as! String
        print(version);
        screenLabel.text = version
        
        theWebView!.evaluateJavaScript("set_headline('\(version)')", completionHandler: {(result, error) -> Void in
            print("\(result) \(error)")
        })
        
    }
}