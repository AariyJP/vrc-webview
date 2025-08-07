import SwiftUI

struct LocationsView: View {
    let websiteURL = URL(string: "https://vrchat.com/home")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    @State private var zoomScale = 0.55
    @State private var jsToExecute: String? = nil // New state for JS execution
    
    var body: some View {
        VStack {
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
            CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, zoomScale: $zoomScale, javaScriptToInject: js, javaScriptToExecute: $jsToExecute)
        }
    }
}

#Preview {
    LocationsView()
}
