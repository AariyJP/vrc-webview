import SwiftUI

struct ContentView: View {
    @State private var javaScriptToExecute: String? = nil
    @State private var webViewReloadTrigger = false
    @State private var isLoading = true
    @State private var zoomScale: Double = 1.0

    var body: some View {
        TabView {
            LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "map.fill")
                }
            FriendsView()
                .tabItem {
                    Label("Friends", systemImage: "person.3.fill")
                }
            MessagesView()
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            // if autoLogin && !username.isEmpty && !password.isEmpty {
            //     let js = """
            //     document.querySelector('input[name="username_email"]').value = '\(username)';
            //     document.querySelector('input[name="password"]').value = '\(password)';
            //     document.querySelector('button[type="submit"]').click();
            //     """
            //     javaScriptToExecute = js
            // }
        }
    }
}

// Preview
#Preview {
    ContentView()
}
