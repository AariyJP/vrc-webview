import SwiftUI

struct FriendsView: View {
    let websiteURL = URL(string: "https://vrchat.com/home")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    @State private var zoomScale = 0.8
    
    var body: some View {
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
        CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, zoomScale: $zoomScale, javaScriptToInject: friendsButtonScript)
        .tabItem {
            Label("Friends", systemImage: "person.3.fill")
        }
    }
}

#Preview {
    FriendsView()
}
