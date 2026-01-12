
import SwiftUI
struct RootView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        Group {
            if router.currentUser == nil {
                NavigationStack(path: $router.path) {
                    LoginView()
                        .navigationDestination(isPresented: $router.showForgotPassword) {
                            ForgotPasswordView()
                        }
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .register:
                                RegisterView()
                            case .roleSelection:
                                RoleSelectionView()
                            default:
                                EmptyView()
                            }
                        }
                }
            } else {
                NavigationStack(path: $router.path) {
                    mainAppView
                        .navigationDestination(for: AppRoute.self) { route in
                            NavigationDestinationView(route: route)
                        }
                }
            }
        }
        .animation(.easeInOut, value: router.currentUser == nil)
    }
    
    @ViewBuilder
    private var mainAppView: some View {
        if router.currentUser?.role == .admin {
            AdminMainView()
        } else {
            CustomerMainView()
        }
    }
}

// MARK: - Navigation Destination Router
struct NavigationDestinationView: View {
    let route: AppRoute
    
    var body: some View {
        switch route {
        case .roleSelection:
            RoleSelectionView()
        case .adminMain:
            AdminMainView()
                .navigationBarBackButtonHidden(true)
        case .customerMain:
            CustomerMainView()
                .navigationBarBackButtonHidden(true)
        case .areaManagement:
            AreaManagementView()
        case .editAreaStatus(let area):
            EditAreaStatusView(area: area)
        case .systemOverview:
            SystemOverviewView()
        case .areaStatus(let area):
            AreaStatusView(area: area)
        case .waterTips:
            WaterTipsView()
        case .tipDetail(let tip):
            TipDetailView(tip: tip)
        case .dailyUsage:
            DailyUsageView()
        case .weeklyUsage:
            WeeklyUsageView()
        case .monthlyUsage:
            MonthlyUsageView()
        case .customerSettings:
            SettingsView()
        case .adminSettings:
            AdminSettingsView()
        case .helpCenter:
            HelpCenterView()
        case .contactSupport:
            ContactSupportView()
        case .waterSources:
            WaterSourceListView()
        case .waterSourceDetail:
            Text("Source Details")
        case .outageList:
            OutageListView()
        case .outageDetail(let outage):
            OutageDetailView(outage: outage)
        case .createOutage:
            CreateOutageView()
        case .waterAvailability:
            WaterAvailabilityView()
        case .pumpControl:
            PumpControlView()
        case .tankLevels:
            TankLevelView()
        case .changePassword:
            ChangePasswordView()
        case .privacyPolicy:
            PrivacyPolicyView()
        case .termsOfService:
            TermsOfServiceView()
        case .exportData:
            ExportDataView()
        case .systemLogs:
            SystemLogsView()
        case .notificationHistory:
            NotificationHistoryView()
        case .notificationDetail(let notification):
            NotificationDetailView(notification: notification)
        case .waterMap:
            MapWaterFlowMapView()
        default:
            Text("Implementation pending for \(String(describing: route))")
                .foregroundColor(.textSecondary)
        }
    }
}


