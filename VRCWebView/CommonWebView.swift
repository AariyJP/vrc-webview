import SwiftUI
import WebKit
import SafariServices

struct CommonWebView: View {
    let websiteURL: URL
    @Binding var isLoading: Bool
    @Binding var webViewReloadTrigger: Bool
    @Binding var zoomScale: Double
    var javaScriptToInject: String? = nil // New parameter
    @Binding var javaScriptToExecute: String? // New parameter for executing JS
    let appColor = Color(
        red: 7/255.0,
        green: 36/255.0,
        blue: 43/255.0
    )

    var body: some View {
        ZStack {
            ScrollView {
                let screenHeight = UIScreen.main.bounds.height
                let statusBarHeight = UIApplication.shared.statusBarFrame.height
                let appHeight = screenHeight - statusBarHeight
                GeometryReader { geometry in
                    WebView(url: websiteURL, isLoading: $isLoading, zoomScale: $zoomScale, reloadTrigger: webViewReloadTrigger, onLoadCompletion: {
                        isLoading = false
                    }, javaScriptToInject: javaScriptToInject, javaScriptToExecute: $javaScriptToExecute) // Pass new parameter
                    .opacity(isLoading ? 0 : 1)
                    .background(appColor)
                }
                .frame(minHeight: appHeight - 130)
                .background(appColor)
            }
            .ignoresSafeArea(edges: .bottom)
            .background(appColor)
            .refreshable {
                isLoading = true
                webViewReloadTrigger.toggle()
                while isLoading {
                    await Task.yield()
                }
            }
            if isLoading {
                ProgressView().scaleEffect(2.0)
            }
        }
        .background(appColor)
    }
}
