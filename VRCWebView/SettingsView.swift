import SwiftUI

struct SettingsView: View {
    @State private var isAirplaneModeOn = false
    @State private var wifiEnabled = true
    @State private var bluetoothEnabled = true
    @State private var notificationsEnabled = true
    @State private var brightness: Double = 0.5

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("ネットワーク")) {
                    Toggle(isOn: $isAirplaneModeOn) {
                        Label("機内モード", systemImage: "airplane")
                    }
                    Toggle(isOn: $wifiEnabled) {
                        Label("Wi-Fi", systemImage: "wifi")
                    }
                    Toggle(isOn: $bluetoothEnabled) {
                        Label("Bluetooth", systemImage: "bluetooth")
                    }
                }

                Section(header: Text("一般")) {
                    NavigationLink(destination: Text("情報")) {
                        Label("情報", systemImage: "info.circle.fill")
                    }
                    NavigationLink(destination: Text("ソフトウェア・アップデート")) {
                        Label("ソフトウェア・アップデート", systemImage: "arrow.triangle.2.circlepath")
                    }
                    NavigationLink(destination: Text("日付と時刻")) {
                        Label("日付と時刻", systemImage: "calendar")
                    }
                }

                Section(header: Text("表示と明るさ")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Label("通知", systemImage: "bell.fill")
                    }
                    HStack {
                        Image(systemName: "sun.min.fill")
                        Slider(value: $brightness, in: 0...1)
                        Image(systemName: "sun.max.fill")
                    }
                }

                Section(header: Text("プライバシーとセキュリティ")) {
                    NavigationLink(destination: Text("位置情報サービス")) {
                        Label("位置情報サービス", systemImage: "location.fill")
                    }
                    NavigationLink(destination: Text("連絡先")) {
                        Label("連絡先", systemImage: "person.crop.circle.fill")
                    }
                }
            }
            .navigationTitle("VRCW")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
