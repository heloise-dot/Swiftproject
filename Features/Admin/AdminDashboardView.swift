import SwiftUI

struct AdminDashboardView: View {
    @State private var areas: [Area] = [
        Area(name: "Kigali Central", status: .available, population: 50000, waterSource: "Main Reservoir"),
        Area(name: "Gasabo", status: .lowPressure, population: 35000, waterSource: "Pump Station A"),
        Area(name: "Nyarugenge", status: .outage, population: 40000, waterSource: "Treatment Plant"),
        Area(name: "Kicukiro", status: .available, population: 30000, waterSource: "Well System")
    ]
    
    @State private var activeOutages = 2
    @State private var totalCustomers = 155000
    @State private var systemHealth = 85
    
    var body: some View {
        // NavigationStack removed to avoid nesting
            ZStack {
                Color.backgroundDark.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            SectionHeader(title: "System Overview")
                            
                            HStack(spacing: 16) {
                                DashboardCard(
                                    title: "Active Outages",
                                    value: "\(activeOutages)",
                                    icon: "exclamationmark.triangle.fill",
                                    color: .red
                                )
                                
                                DashboardCard(
                                    title: "Total Customers",
                                    value: "\(totalCustomers.formatted())",
                                    icon: "person.3.fill",
                                    color: .blue
                                )
                            }
                            
                            HStack(spacing: 16) {
                                DashboardCard(
                                    title: "System Health",
                                    value: "\(systemHealth)%",
                                    icon: "heart.fill",
                                    color: .green
                                )
                                
                                DashboardCard(
                                    title: "Areas Monitored",
                                    value: "\(areas.count)",
                                    icon: "map.fill",
                                    color: .purple
                                )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        VStack(spacing: 16) {
                            HStack {
                                Text("Area Management")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.textPrimary)
                                
                                Spacer()
                                
                                NavigationLink(value: AppRoute.areaManagement) {
                                    Text("Manage")
                                        .font(.subheadline)
                                        .foregroundColor(.primaryBlue)
                                }
                            }
                            .padding(.horizontal)
                            
                            ForEach(areas) { area in
                                NavigationLink(value: AppRoute.editAreaStatus(area)) {
                                    AdminAreaCard(area: area)
                                }
                                .buttonStyle(.interactive)
                            }
                        }
                        .padding(.horizontal)
                        
                        NavigationLink(value: AppRoute.areaManagement) {
                            HStack {
                                Text("View All Areas")
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
                        .padding(.horizontal)
                        
                        NavigationLink(value: AppRoute.systemOverview) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("System Overview")
                                        .font(.headline)
                                        .foregroundColor(.textPrimary)
                                    
                                    Text("Monitor water sources and infrastructure")
                                        .font(.subheadline)
                                        .foregroundColor(.textSecondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .font(.title2)
                                    .foregroundColor(.primaryBlue)
                            }
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(16)
                        }
                        .buttonStyle(.interactive)
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.large)
    }
}

struct DashboardCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.textPrimary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
    }
}

struct AdminAreaCard: View {
    let area: Area
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(area.name)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Text(area.waterSource)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            StatusBadge(text: area.status.rawValue, color: statusColor(for: area.status))
            
            Image(systemName: "chevron.right")
                .foregroundColor(.textSecondary)
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
    }
    
    private func statusColor(for status: WaterStatus) -> Color {
        switch status {
        case .available: return .green
        case .lowPressure: return .yellow
        case .scheduledMaintenance: return .orange
        case .outage: return .red
        }
    }
}

#Preview {
    AdminDashboardView()
}

