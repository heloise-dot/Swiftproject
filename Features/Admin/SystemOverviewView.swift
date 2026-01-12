import SwiftUI

struct SystemOverviewView: View {
    @State private var systemHealth = 85
    @State private var totalCapacity = 140000
    @State private var currentUsage = 118000
    @State private var activePumps = 3
    @State private var totalPumps = 4
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        SectionHeader(title: "System Health")
                        
                        VStack(spacing: 16) {
                            VStack(spacing: 12) {
                                Text("\(systemHealth)%")
                                    .font(.system(size: 64, weight: .bold))
                                    .foregroundColor(healthColor(for: systemHealth))
                                
                                Text("Overall System Health")
                                    .font(.subheadline)
                                    .foregroundColor(.textSecondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.cardDark)
                            .cornerRadius(20)
                            
                            HStack(spacing: 16) {
                                DashboardCard(
                                    title: "Capacity",
                                    value: "\(Int(totalCapacity / 1000))k L",
                                    icon: "drop.fill",
                                    color: .blue
                                )
                                
                                DashboardCard(
                                    title: "In Use",
                                    value: "\(Int(currentUsage / 1000))k L",
                                    icon: "chart.bar.fill",
                                    color: .green
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Infrastructure")
                        
                        NavigationLink(destination: WaterSourceListView()) {
                            InfoCard(
                                icon: "drop.fill",
                                title: "Water Sources",
                                value: "5 Active",
                                color: .blue
                            ) {}
                        }
                        .buttonStyle(.interactive)
                        
                        NavigationLink(destination: PumpControlView()) {
                            InfoCard(
                                icon: "gearshape.fill",
                                title: "Pump Stations",
                                value: "\(activePumps) / \(totalPumps) Active",
                                color: .orange
                            ) {}
                        }
                        .buttonStyle(.interactive)
                        
                        NavigationLink(destination: TankLevelView()) {
                            InfoCard(
                                icon: "cylinder.fill",
                                title: "Storage Tanks",
                                value: "4 Tanks",
                                color: .purple
                            ) {}
                        }
                        .buttonStyle(.interactive)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Quick Actions")
                        
                        NavigationLink(destination: AreaManagementView()) {
                            HStack {
                                Text("Manage Areas")
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
                        .buttonStyle(.interactive)
                        
                        NavigationLink(destination: CreateOutageView()) {
                            HStack {
                                Text("Create Outage")
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
                        .buttonStyle(.interactive)
                        
                        NavigationLink(destination: SendNotificationView()) {
                            HStack {
                                Text("Send Notification")
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
                        .buttonStyle(.interactive)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("System Overview")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private func healthColor(for percentage: Int) -> Color {
        if percentage >= 80 {
            return .green
        } else if percentage >= 60 {
            return .yellow
        } else {
            return .red
        }
    }
}

#Preview {
    NavigationStack {
        SystemOverviewView()
    }
}

