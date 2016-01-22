import UIKit
import WebKit

extension WKWebView: FLWebViewProvider {
    
    // Use associated objects to set and get the request ivar
    func associatedObjectKey() -> String {
        return "kAssociatedObjectKey"
    }
    
    var request: NSURLRequest? {
        get {
            return objc_getAssociatedObject(self, associatedObjectKey()) as? NSURLRequest
        }
        set(newValue) {
            objc_setAssociatedObject(self, associatedObjectKey(), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // A simple convenience initializer, this allows for WKWebView(delegateView:) initialization
    convenience init(delegateView: AnyObject) {
        self.init()
        self.UIDelegate = delegateView as? WKUIDelegate
        self.navigationDelegate = delegateView as? WKNavigationDelegate
        self.scrollView.bounces = false
    }
    
    // We will need to set both the UIDelegate AND navigationDelegate in the case of WebKit
    func flSetDelegateViews(viewController: ViewController) {
        self.UIDelegate = viewController as WKUIDelegate
        self.navigationDelegate = viewController as WKNavigationDelegate
    }
    
    func flURL() -> NSURL? {
        return self.URL
    }
    
    func flCanGoBack() -> Bool {
        return self.canGoBack
    }
    
    func flCanGoForward() -> Bool {
        return self.canGoForward
    }
    
    func flLoadRequest(urlRequest: NSURLRequest){
        self.loadRequest(urlRequest)
    }
    
    // A quick method for loading requests based on strings in a URL format
    func flLoadRequestFromString(urlNameAsString: String!) {
        let requesturl = NSURL(string: urlNameAsString!)
        let request = NSURLRequest(URL: requesturl!)
        self.loadRequest(request)
    }
    
    func flLoadRequestFromLocalPath(localFilePath: NSURL!) {
        let request = NSURLRequest(URL: localFilePath)
        self.loadRequest(request)
    }
    
    // Pass this up the chain and let WebKit handle it
    func flEvaluateJavaScript(javascriptString: String!, completionHandler: (AnyObject, NSError) -> ()) {
        self.evaluateJavaScript(javascriptString, completionHandler: { (result, error) -> Void in
            print("\(result) \(error)")
        })
    }
}
