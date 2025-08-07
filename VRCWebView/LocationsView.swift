import SwiftUI

struct LocationsView: View {
    let websiteURL = URL(string: "https://vrchat.com/home")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    
    var body: some View {
    // 「Show More Locations」ボタンを押し続けるJavaScript
        let js = """
        function clickShowMore() {
            const buttons = document.querySelectorAll('button');
            let clicked = false;
            for (let i = 0; i < buttons.length; i++) {
                if (buttons[i].textContent.trim() === 'Show More Locations') {
                    buttons[i].click();
                    clicked = true;
                    break;
                }
            }
            setTimeout(clickShowMore, 500);
        }
        window.addEventListener('load', clickShowMore);
        """
        CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, javaScriptToInject: js)
    }
}

#Preview {
    LocationsView()
}
