import SwiftUI

struct MessagesView: View {
    let websiteURL = URL(string: "https://vrchat.com/home/messages")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    @State private var zoomScale = 0.8
    @State private var jsToExecute: String? = nil // New state for JS execution
    
    var body: some View {
        NavigationStack {
            CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, zoomScale: $zoomScale, javaScriptToExecute: $jsToExecute)
                .navigationTitle("Messages")
                .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MessagesView()
}
