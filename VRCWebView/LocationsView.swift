import SwiftUI

struct LocationsView: View {
    let websiteURL = URL(string: "https://vrchat.com/home")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    @State private var zoomScale = 0.55
    @State private var jsToExecute: String? = nil
    @AppStorage("autoLogin") private var autoLogin = false
    @AppStorage("username") private var username: String = ""
    @AppStorage("password") private var password: String = ""
    
    var body: some View {
        NavigationStack {
        // 「Show More Locations」ボタンを押し続けるJavaScript
            var js = """
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
            // function login() {
            //     setTimeout(() => {
            //     const usernameInput = document.querySelector('input[name="username_email"]');
            //     usernameInput.focus();
            //     usernameInput.value = '\($username.wrappedValue)';
            //     usernameInput.dispatchEvent(new Event('change'));
            //     }, 1000);
            //     setTimeout(() => {
            //     const passwordInput = document.querySelector('input[name="password"]');
            //     passwordInput.focus();
            //     passwordInput.value = '\($password.wrappedValue)';
            //     passwordInput.dispatchEvent(new Event('change'));
            //     }, 2000);
            //     setTimeout(() => {
            //         document.querySelector('button[type="submit"]').click();
            //     }, 3000);
            // }
            // window.addEventListener('load', () => {setTimeout(login, 5000);});
            """
//            if autoLogin
//            {
//                let _ = js += """
//
//                """
//            }
            CommonWebView(websiteURL: websiteURL, isLoading: $isLoading, webViewReloadTrigger: $webViewReloadTrigger, zoomScale: $zoomScale, javaScriptToInject: js, javaScriptToExecute: $jsToExecute)
                .navigationTitle("Locations")
                .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LocationsView()
}
