import SwiftUI

struct CustomerHomeView: View {
    @State private var areas: [Area] = [
        Area(name: "Kigali Central", status: .available, population: 50000, waterSource: "Main Reservoir"),
        Area(name: "Gasabo", status: .lowPressure, population: 35000, waterSource: "Pump Station A"),
        Area(name: "Nyarugenge", status: .outage, population: 40000, waterSource: "Treatment Plant"),
        Area(name: "Kicukiro", status: .available, population: 30000, waterSource: "Well System")
    ]
    
    @State private var recentOutages: [Outage] = [
        Outage(area: "Nyarugenge", severity: .major, description: "Main pipeline maintenance", startTime: Date().addingTimeInterval(-3600), estimatedEndTime: Date().addingTimeInterval(7200), affectedCustomers: 5000, cause: "Scheduled Maintenance"),
        Outage(area: "Gasabo", severity: .minor, description: "Low pressure reported", startTime: Date().addingTimeInterval(-1800), affectedCustomers: 1200, cause: "High Demand")
    ]
    
    var body: some View {
        // NavigationStack removed to avoid nesting
            ZStack {
                Color.backgroundDark.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(title: "Water Availability")
                            
                            ForEach(areas) { area in
                                NavigationLink(value: AppRoute.areaStatus(area)) {
                                    StatusCard(area: area.name, status: area.status.rawValue, color: statusColor(for: area.status))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Recent Outages")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.textPrimary)
                                
                                Spacer()
                                
                                NavigationLink(value: AppRoute.outageList) {
                                    Text("View All")
                                        .font(.subheadline)
                                        .foregroundColor(.primaryBlue)
                                }
                            }
                            .padding(.horizontal)
                            
                            ForEach(recentOutages.prefix(2)) { outage in
                                NavigationLink(value: AppRoute.outageDetail(outage)) {
                                    OutageRowView(outage: outage)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        
                        NavigationLink(value: AppRoute.waterAvailability) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Check Your Area")
                                        .font(.headline)
                                        .foregroundColor(.textPrimary)
                                    
                                    Text("Search for water status in any area")
                                        .font(.subheadline)
                                        .foregroundColor(.textSecondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .foregroundColor(.primaryBlue)
                            }
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(16)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
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

struct OutageRowView: View {
    let outage: Outage
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(outage.area)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Text(outage.description)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
                    .lineLimit(2)
                
                Text(outage.startTime, style: .relative)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            StatusBadge(text: outage.severity.rawValue, color: severityColor(for: outage.severity))
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
    }
    
    private func severityColor(for severity: OutageSeverity) -> Color {
        switch severity {
        case .minor: return .blue
        case .moderate: return .yellow
        case .major: return .orange
        case .critical: return .red
        }
    }
}

#Preview {
    CustomerHomeView()
}



