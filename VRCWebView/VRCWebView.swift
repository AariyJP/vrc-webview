import SwiftUI
import WebKit
import SafariServices

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    @Binding var zoomScale: Double
    let reloadTrigger: Bool
    var onLoadCompletion: (() -> Void)?
    var javaScriptToInject: String? = nil // New parameter

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
            parent.onLoadCompletion?()
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.onLoadCompletion?()
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.onLoadCompletion?()
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
        configuration.userContentController.addUserScript(WKUserScript(source: """
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=\(zoomScale), user-scalable=no';
        document.head.appendChild(meta);
        """, injectionTime: .atDocumentEnd, forMainFrameOnly: true))
        do {
            let injectJs = try String(contentsOfFile: Bundle.main.path(forResource: "inject", ofType: "js")! , encoding: .utf8)
            configuration.userContentController.addUserScript(WKUserScript(source: injectJs, injectionTime: .atDocumentEnd, forMainFrameOnly: true))
        }
        catch {}
        
        
        // Inject custom JavaScript if provided
        if let js = javaScriptToInject {
            let customScript = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            configuration.userContentController.addUserScript(customScript)
        }
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator // Set the UI delegate
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.isInspectable = true
        webView.backgroundColor = .clear
        webView.isOpaque = false
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
