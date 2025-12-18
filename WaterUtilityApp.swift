import SwiftUI

@main
struct WaterUtilityApp: App {
    // 1. Create the StateObject here
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            // 2. Pass it to the root view
            LoginView()
                .environmentObject(router)
        }
    }
}
