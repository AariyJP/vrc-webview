import SwiftUI

struct ProfileView: View {
    let websiteURL = URL(string: "https://vrchat.com/home/user/me")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    @State private var zoomScale = 0.8
    @State private var jsToExecute: String? = nil // New state for JS execution
    @State private var editState = false
    
    var body: some View {
        NavigationStack {
            CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, zoomScale: $zoomScale, javaScriptToExecute: $jsToExecute)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            jsToExecute = "document.querySelector('[aria-label=\"Edit Profile\"]').click();"
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                }
        }

    }
}

#Preview {
    ProfileView()
}
