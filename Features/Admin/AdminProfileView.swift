import SwiftUI

struct AdminProfileView: View {
    @EnvironmentObject var router: AppRouter
    @State private var user = User(
        name: "Admin User",
        email: "admin@waterutility.rw",
        phone: "+250 788 000 000",
        address: "Water Utility HQ",
        role: .admin,
        area: "All Areas"
    )
    
    var body: some View {
            ZStack {
                Color.backgroundDark.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.primaryBlue)
                            
                            Text(user.name)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.textPrimary)
                            
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            StatusBadge(text: "Administrator", color: .primaryBlue)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.cardDark)
                        .cornerRadius(20)
                        
                        VStack(spacing: 16) {
                            NavigationLink(value: AppRoute.adminSettings) {
                                ProfileRowView(icon: "gearshape.fill", title: "Settings", color: .gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(value: AppRoute.systemOverview) {
                                ProfileRowView(icon: "chart.line.uptrend.xyaxis", title: "System Overview", color: .blue)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(value: AppRoute.waterSources) {
                                ProfileRowView(icon: "drop.fill", title: "Water Sources", color: .cyan)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            InfoCard(
                                icon: "phone.fill",
                                title: "Phone",
                                value: user.phone,
                                color: .blue
                            )
                            
                            InfoCard(
                                icon: "envelope.fill",
                                title: "Email",
                                value: user.email,
                                color: .orange
                            )
                            
                            InfoCard(
                                icon: "location.fill",
                                title: "Service Area",
                                value: user.area,
                                color: .purple
                            )
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            withAnimation {
                                router.popToRoot()
                                router.currentUser = nil
                            }
                        }) {
                            Text("Sign Out")
                                .font(.headline)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    AdminProfileView()
        .environmentObject(AppRouter())
}

