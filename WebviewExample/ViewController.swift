//
//  ViewController.swift
//  WebviewExample
//
//  Created by jeff on 21/01/2016.
//  Copyright © 2016 jeff. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

    @IBOutlet weak var screenLabel: UILabel!
    
    var flWebView: FLWebViewProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wkEnabled = true
        let theConfiguration = WKWebViewConfiguration()
        theConfiguration.userContentController.addScriptMessageHandler(self, name: "interOp")

        // Check if WKWebView is available
        if (wkEnabled && NSClassFromString("WKWebView") != nil) {
            let w = WKWebView(frame: self.view.frame, configuration: theConfiguration)
            w.frame = self.view.frame
            self.flWebView = w
            self.view.insertSubview(self.flWebView as! WKWebView, atIndex: 0)

        } else {
            // In this case we have to fall back on UIWebView
            let w = UIWebView(delegateView: self)
            w.frame = self.view.frame
            self.flWebView = w
            self.view.insertSubview(self.flWebView as! UIWebView, atIndex: 0)
        }
        
        // Load a page, in this case we will load our favorite website
        let filePath = NSBundle.mainBundle().pathForResource("index", ofType: "html", inDirectory: "assets/jason-html")
        let request = NSURLRequest(URL: NSURL.fileURLWithPath(filePath!))
        self.flWebView!.flLoadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        let sentData = message.body as! NSDictionary
        let index:Int = Int(sentData["index"] as! NSNumber)
        screenLabel.text = String(index)
        print(index)
        let param = "hello javascript"
        self.flWebView!.flEvaluateJavaScript("alert('\(param)')", completionHandler: {(result, error) -> Void in
            print("userContentController \(result) \(error)")
        })
    }


}

