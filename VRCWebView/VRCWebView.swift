import SwiftUI
import WebKit
import SafariServices

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    let reloadTrigger: Bool
    var onLoadCompletion: (() -> Void)? // Add new completion handler

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebView
        var lastReloadTrigger: Bool = false
        var viewController: UIViewController?
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            parent.onLoadCompletion?() // Call completion handler on finish
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.onLoadCompletion?() // Call completion handler on fail
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.onLoadCompletion?() // Call completion handler on fail
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                if let url = navigationAction.request.url {
                    let safariViewController = SFSafariViewController(url: url)
                    safariViewController.modalPresentationStyle = .pageSheet
                    self.viewController?.present(safariViewController, animated: true)
                }
            }
            return nil
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        // 拡大縮小を無効にするJavaScript
        let scriptSource = """
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=0.55, user-scalable=no';
        document.head.appendChild(meta);
        """
        // WKUserScriptを作成し、configurationに追加
        let viewportScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        configuration.userContentController.addUserScript(viewportScript)
        
        // CSSを注入するJavaScript
        let cssInjectionScriptSource = """
        var style = document.createElement('style');
        style.innerHTML = '.home-content { padding-right: 20px !important; }';
        document.head.appendChild(style);
        """
        let cssInjectionScript = WKUserScript(source: cssInjectionScriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        configuration.userContentController.addUserScript(cssInjectionScript)
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator // Set the UI delegate
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.isInspectable = true
        
        DispatchQueue.main.async {
            context.coordinator.viewController = webView.window?.rootViewController
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if reloadTrigger != context.coordinator.lastReloadTrigger {
            uiView.reload()
        }
        context.coordinator.lastReloadTrigger = reloadTrigger
    }
}
