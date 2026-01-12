import SwiftUI

@main
struct WaterUtilityApp: App {
    @StateObject private var router = AppRouter()
    
    init() {
        NavigationBarTheme.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
        }
    }
}
