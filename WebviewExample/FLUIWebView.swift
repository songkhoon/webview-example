import UIKit

extension UIWebView: FLWebViewProvider {

    // A simple convenience initializer, this allows for UIWebView(delegateView:) initialization
    convenience init(delegateView: UIWebViewDelegate) {
        self.init()
        self.delegate = delegateView
        self.scrollView.bounces = false
    }
    
    // UIWebView has one delegate method so this is pretty straight forward
    func flSetDelegateViews(viewController: ViewController) {
        delegate = viewController
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
    
    func flURL() -> NSURL? {
        return self.request?.URL
    }
    
    func flEvaluateJavaScript(javascriptString: String!, completionHandler: (AnyObject, NSError) -> ()) {
        // Have the WebView evaluate the javascript string
        let string = stringByEvaluatingJavaScriptFromString(javascriptString)
        
        // Call the completion handler from there
        completionHandler(string!, NSError(domain: "astro", code: -1, userInfo: [NSLocalizedDescriptionKey:"error message"]))
    }
    
    func setScalesPageToFit(setPages: Bool!) {
        self.scalesPageToFit = setPages
    }
    
}
