import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
//            HomeView()
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
//            SettingsView()
//                .tabItem {
//                    Label("Settings", systemImage: "gear")
//                }
        }
    }
}

// Preview
#Preview {
    ContentView()
}
