import SwiftUI

struct FriendsView: View {
    let websiteURL = URL(string: "https://vrchat.com/home")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    @State private var zoomScale = 0.8
    @State private var jsToExecute: String? = nil // New state for JS execution
    
    var body: some View {
        NavigationStack {
            let friendsButtonScript = """
            function clickFriendsButton() {
                const button = document.querySelector('.friends-button');
                if (button) {
                    button.click();
                }
                setTimeout(clickFriendsButton, 500);
            }
            window.addEventListener('load', clickFriendsButton);
            """
            CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, zoomScale: $zoomScale, javaScriptToInject: friendsButtonScript, javaScriptToExecute: $jsToExecute)
        }
    }
}

#Preview {
    FriendsView()
}
