import SwiftUI

struct CustomerProfileView: View {
    @State private var user = User(
        name: "John Doe",
        email: "john.doe@example.com",
        phone: "+250 788 123 456",
        address: "Kigali Central, KG 123 St",
        role: .customer,
        area: "Kigali Central"
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
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.cardDark)
                        .cornerRadius(20)
                        
                        VStack(spacing: 16) {
                            NavigationLink(destination: EditProfileView(user: $user)) {
                                ProfileRowView(icon: "person.fill", title: "Edit Profile", color: .blue)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(value: AppRoute.customerSettings) {
                                ProfileRowView(icon: "gearshape.fill", title: "Settings", color: .gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(value: AppRoute.helpCenter) {
                                ProfileRowView(icon: "questionmark.circle.fill", title: "Help Center", color: .green)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(value: AppRoute.contactSupport) {
                                ProfileRowView(icon: "message.fill", title: "Contact Support", color: .orange)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            InfoCard(
                                icon: "location.fill",
                                title: "Service Area",
                                value: user.area,
                                color: .purple
                            )
                            
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
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
    }
}

struct ProfileRowView: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.2))
                .cornerRadius(10)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.textPrimary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.textSecondary)
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
    }
}

#Preview {
    CustomerProfileView()
}

