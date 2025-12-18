import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: AppRouter
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var isLoading = false
    @State private var showError = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Color.backgroundDark.ignoresSafeArea()
                
                VStack(spacing: 32) {
                    Spacer()
                    
                    VStack(spacing: 12) {
                        Image(systemName: "drop.fill")
                            .resizable()
                            .frame(width: 70, height: 90)
                            .foregroundColor(.primaryBlue)
                            .symbolEffect(.pulse, options: .repeating)
                        
                        Text("Water Utility")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        Text("Check water availability instantly")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.bottom, 20)
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            TextField("Enter your email", text: $email)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(12)
                                .foregroundColor(.textPrimary)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            HStack {
                                if showPassword {
                                    TextField("Enter your password", text: $password)
                                        .textFieldStyle(.plain)
                                } else {
                                    SecureField("Enter your password", text: $password)
                                        .textFieldStyle(.plain)
                                }
                                
                                Button(action: {
                                    withAnimation {
                                        showPassword.toggle()
                                    }
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.textSecondary)
                                }
                            }
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                            .foregroundColor(.textPrimary)
                        }
                    }
                    
                    VStack(spacing: 16) {
                        NavigationLink(value: AppRoute.roleSelection) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.textPrimary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.primaryBlue)
                                .cornerRadius(14)
                                .shadow(color: .primaryBlue.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        HStack {
                            Button("Forgot Password?") {
                                router.showForgotPassword = true
                            }
                            .foregroundColor(.primaryBlue)
                            .font(.subheadline)
                            
                            Spacer()
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundColor(.textSecondary)
                        
                        NavigationLink("Sign Up") {
                            RegisterView()
                        }
                        .foregroundColor(.primaryBlue)
                        .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .navigationDestination(isPresented: $router.showForgotPassword) {
                ForgotPasswordView()
            }
            .navigationDestination(for: AppRoute.self) { route in
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
                    DailyUsageView() // Ensure this view exists
                case .weeklyUsage:
                    WeeklyUsageView() // Ensure this view exists
                case .monthlyUsage:
                    MonthlyUsageView() // Ensure this view exists
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
                case .waterSourceDetail(let source):
                    WaterSourceDetailView(source: source)
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
                    TankLevelView() // Ensure this view exists
                case .notificationHistory:
                    NotificationHistoryView()
                case .notificationDetail(let notification):
                    NotificationDetailView(notification: notification)
                // Remove duplicates that were here
                default:
                    Text("Implementation pending for this route")
                        .foregroundColor(.textSecondary)
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppRouter())
}

