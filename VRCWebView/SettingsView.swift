import SwiftUI
import WebKit // Required for WKWebView data deletion
import Foundation // Required for exit()

struct SettingsView: View {
    @AppStorage("autoLogin") private var autoLogin = false
    @AppStorage("username") private var username: String = ""
    @AppStorage("password") private var password: String = ""
    @State private var showingLogoutAlert = false // State to control alert presentation

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("アカウント")) {
                    Toggle(isOn: $autoLogin) {
                        Label("自動ログイン", systemImage: "person.fill")
                    }
                    TextField("ユーザー名", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    TextField("パスワード", text: $password)
                    Button(action: {
                        WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), modifiedSince: Date.distantPast) {
                            showingLogoutAlert = true
                        }
                    }) {
                        Text("ログアウト")
                            .foregroundColor(.red)
                    }
                }
                Section {
                    
                }
            }
            .navigationTitle("設定")
            .alert(isPresented: $showingLogoutAlert) { // Alert modifier
                Alert(
                    title: Text("ログアウトしました。アプリを終了します。"),
                    dismissButton: .default(Text("OK")) {
                        exit(0)
                    }
                )
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
