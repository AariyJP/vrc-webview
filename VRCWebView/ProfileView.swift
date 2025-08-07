import SwiftUI

struct ProfileView: View {
    let websiteURL = URL(string: "https://vrchat.com/home/user/me")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    @State private var zoomScale = 0.8
    
    var body: some View {
        CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, zoomScale: $zoomScale)
        .tabItem {
            Label("Profile", systemImage: "person.fill")
        }
    }
}

#Preview {
    ProfileView()
}
