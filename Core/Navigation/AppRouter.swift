import SwiftUI

// Ensure this matches your actual User model name
// If you don't have one yet, uncomment the line below:
// struct User: Hashable { let id: UUID; var name: String }

enum AppRoute: Hashable {
    case login
    case roleSelection
    case register
    case customerMain
    case adminMain
    case adminDashboard
    case customerHome
    
    // Admin Sub-screens
    case areaManagement
    case editAreaStatus(Area)
    case systemOverview
    
    // Customer Sub-screens
    case areaStatus(Area)
    case outageList
    case outageDetail(Outage)
    case waterAvailability
    case notificationDetail(NotificationItem)
    case waterTips
    case tipDetail(WaterTip)
    case helpCenter
    case contactSupport
    case customerProfile
    case editProfile
    case customerSettings
    case dailyUsage
    case weeklyUsage
    case monthlyUsage
    
    // Admin Extras
    case createOutage
    case outageHistory
    case notificationHistory
    case sendNotification
    case adminProfile
    case adminSettings
    case pumpControl
    case tankLevels
    case waterSources
    case waterSourceDetail(WaterSource)
}

final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var showForgotPassword = false
    @Published var currentUser: User? // Ensure 'User' is also Hashable

    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
 }


struct WaterTip: Identifiable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var category: String
    var impact: String
    
    var icon: String
    
    init(id: UUID = UUID(), title: String, description: String, category: String, impact: String, icon: String = "drop.fill") {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.impact = impact
        self.icon = icon
    }
}
