import Foundation

protocol FLWebViewProvider: class {
    
    func flSetDelegateViews(viewController: ViewController)
    
    var request: NSURLRequest? { get }
    
    func flURL() -> NSURL?
    
    func flLoadRequest(urlRequest: NSURLRequest)
    
    func flLoadRequestFromString(urlNameAsString: String!)
    
    func flLoadRequestFromLocalPath(localFilePath: NSURL!)
    
    func flCanGoBack() -> Bool
    
    func flCanGoForward() -> Bool
    
    func flEvaluateJavaScript(javascriptString: String!, completionHandler: (AnyObject, NSError) -> ())
}