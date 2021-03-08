//
//  WebViewController.swift
//  Net01
//
//  Created by Alexey Golovin on 03.03.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    var webView: WKWebView!
    var receivedURL: String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        let color = "#338522"
        let source = "document.body.style.background = \"\(color)\";"
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        webConfiguration.userContentController = userContentController
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: receivedURL) else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
    }
}
