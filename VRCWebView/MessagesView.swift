import SwiftUI

struct MessagesView: View {
    let websiteURL = URL(string: "https://vrchat.com/home/messages")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    @State private var zoomScale = 0.8
    @State private var jsToExecute: String? = nil // New state for JS execution
    
    var body: some View {
        VStack {
            CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, zoomScale: $zoomScale, javaScriptToExecute: $jsToExecute)
            
            Button("Execute JS (Messages)") {
                jsToExecute = "alert('Hello from MessagesView!');"
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .tabItem {
            Label("Messages", systemImage: "message.fill")
        }
    }
}

#Preview {
    MessagesView()
}
