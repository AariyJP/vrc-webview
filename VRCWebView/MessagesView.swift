import SwiftUI

struct MessagesView: View {
    let websiteURL = URL(string: "https://vrchat.com/home/messages")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    
    var body: some View {
        CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger)
        .tabItem {
            Label("Messages", systemImage: "message.fill")
        }
    }
}

#Preview {
    MessagesView()
}
