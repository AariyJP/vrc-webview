import SwiftUI

struct ContentView: View {
    let websiteURL = URL(string: "https://vrchat.com/home")!
    @State private var isLoading = false
    @State private var webViewReloadTrigger = false
    let appColor = Color(
        red: 7/255.0,
        green: 36/255.0,
        blue: 43/255.0
    )
    
    
    var body: some View {
//        NavigationView {
            
            ZStack {
                
                ScrollView {
                    let screenHeight = UIScreen.main.bounds.height
                    let statusBarHeight = UIApplication.shared.statusBarFrame.height
                    let appHeight = screenHeight - statusBarHeight
                    GeometryReader { geometry in
                        WebView(url: websiteURL, isLoading: $isLoading, reloadTrigger: webViewReloadTrigger, onLoadCompletion: {
                            isLoading = false
                        })
                        .opacity(isLoading ? 0.25 : 1)
                        .background(appColor)
                    }
                    .frame(minHeight: appHeight)
                    .background(appColor)
                    
                }
                .ignoresSafeArea(edges: .bottom)
                .background(appColor)
                .refreshable {
                    isLoading = true
                    webViewReloadTrigger.toggle()
                    while isLoading {
                        await Task.yield()
                    }
                }
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(2.0)
                }
                    
            }
//        }
    }
}

// Preview
#Preview {
    ContentView()
}
