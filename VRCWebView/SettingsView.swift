import SwiftUI

struct SettingsView: View {
    @State private var autoLogin = false
    @State private var username: String = ""
    @State private var password: String = ""

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
                    SecureField("パスワード", text: $password)
                }
            }
            .navigationTitle("設定")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
