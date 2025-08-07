import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
//            HomeView()
            NavigationStack {
                LocationsView()
            }
                .tabItem {
                    Label("Locations", systemImage: "map.fill")
                }
            NavigationStack {
                FriendsView()
            }
                .tabItem {
                    Label("Friends", systemImage: "person.3.fill")
                }
            NavigationStack {
                MessagesView()
            }
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
            NavigationStack {
                ProfileView()
            }
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
