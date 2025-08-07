import SwiftUI

struct ProfileView: View {
    let websiteURL = URL(string: "https://vrchat.com/home/user/me")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    @State private var zoomScale = 0.8
    @State private var jsToExecute: String? = nil // New state for JS execution
    
    var body: some View {
        VStack {
            CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, zoomScale: $zoomScale, javaScriptToExecute: $jsToExecute)
            
            Button("Execute JS") {
                jsToExecute = "location.href=\"https://yahoo.co.jp\""
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .tabItem {
            Label("Profile", systemImage: "person.fill")
        }
    }
}

#Preview {
    ProfileView()
}
