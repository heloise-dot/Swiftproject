import SwiftUI

// MARK: - Customer Home View
// Production-ready home screen with clear information hierarchy
// Optimized for quick access to critical water status information
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
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: .spacingXL) {
                    // MARK: Water Availability Section
                    // Primary information - water status by area
                    VStack(alignment: .leading, spacing: .spacingMD) {
                        SectionHeader(
                            title: "Water Availability",
                            subtitle: "Current status by service area"
                        )
                        
                        LazyVStack(spacing: .spacingMD) {
                            ForEach(areas) { area in
                                NavigationLink(value: AppRoute.areaStatus(area)) {
                                    StatusCard(
                                        area: area.name,
                                        status: area.status.rawValue,
                                        color: statusColor(for: area.status),
                                        subtitle: area.waterSource
                                    )
                                }
                                .buttonStyle(.interactive)
                            }
                        }
                        .padding(.horizontal, .spacingMD)
                    }
                    .padding(.top, .spacingMD)
                    
                    // MARK: Recent Outages Section
                    // Critical alerts - prioritized for visibility
                    if !recentOutages.isEmpty {
                        VStack(alignment: .leading, spacing: .spacingMD) {
                            HStack(alignment: .firstTextBaseline) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Service Alerts")
                                        .font(.heading2)
                                        .foregroundColor(.textPrimary)
                                    
                                    Text("Active outages and notifications")
                                        .font(.bodySmall)
                                        .foregroundColor(.textSecondary)
                                }
                                
                                Spacer()
                                
                                NavigationLink(value: AppRoute.outageList) {
                                    Text("View All")
                                        .font(.labelSmall)
                                        .foregroundColor(.primaryBlue)
                                }
                            }
                            .padding(.horizontal, .spacingMD)
                            
                            LazyVStack(spacing: .spacingMD) {
                                ForEach(recentOutages.prefix(2)) { outage in
                                    NavigationLink(value: AppRoute.outageDetail(outage)) {
                                        OutageRowView(outage: outage)
                                    }
                                    .buttonStyle(.interactive)
                                }
                            }
                            .padding(.horizontal, .spacingMD)
                        }
                    }
                    
                    // MARK: Quick Actions
                    // Prominent call-to-action for area search
                    NavigationLink(value: AppRoute.waterAvailability) {
                        HStack(spacing: .spacingMD) {
                            // Icon container
                            ZStack {
                                RoundedRectangle(cornerRadius: .radiusMD)
                                    .fill(Color.primaryBlue.opacity(0.15))
                                    .frame(width: 56, height: 56)
                                
                                Image(systemName: "magnifyingglass")
                                    .font(.title3)
                                    .foregroundColor(.primaryBlue)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Check Your Area")
                                    .font(.heading3)
                                    .foregroundColor(.textPrimary)
                                
                                Text("Search water status by location")
                                    .font(.bodySmall)
                                    .foregroundColor(.textSecondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.bodyMedium)
                                .foregroundColor(.textTertiary)
                        }
                        .padding(.spacingMD)
                        .background(Color.cardDark)
                        .cornerRadius(.radiusLG)
                        .overlay(
                            RoundedRectangle(cornerRadius: .radiusLG)
                                .stroke(Color.primaryBlue.opacity(0.2), lineWidth: 1.5)
                        )
                    }
                    .buttonStyle(.interactive)
                    .padding(.horizontal, .spacingMD)
                    .padding(.bottom, .spacingMD)
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: Helper Methods
    // Status color mapping for visual consistency
    private func statusColor(for status: WaterStatus) -> Color {
        switch status {
        case .available: return .statusAvailable
        case .lowPressure: return .statusLowPressure
        case .scheduledMaintenance: return .statusMaintenance
        case .outage: return .statusOutage
        }
    }
}

// MARK: - Outage Row Component
// Compact outage display for list views
struct OutageRowView: View {
    let outage: Outage
    
    var body: some View {
        HStack(spacing: .spacingMD) {
            // Severity indicator
            RoundedRectangle(cornerRadius: 4)
                .fill(severityColor(for: outage.severity))
                .frame(width: 4)
            
            VStack(alignment: .leading, spacing: .spacingSM) {
                Text(outage.area)
                    .font(.heading3)
                    .foregroundColor(.textPrimary)
                
                Text(outage.description)
                    .font(.bodyMedium)
                    .foregroundColor(.textSecondary)
                    .lineLimit(2)
                
                HStack(spacing: .spacingMD) {
                    Label("\(outage.affectedCustomers.formatted()) customers", systemImage: "person.3.fill")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                    
                    Text(outage.startTime, style: .relative)
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }
            }
            
            Spacer()
            
            StatusBadge(text: outage.severity.rawValue, color: severityColor(for: outage.severity))
        }
        .padding(.spacingMD)
        .background(Color.cardDark)
        .cornerRadius(.radiusLG)
        .overlay(
            RoundedRectangle(cornerRadius: .radiusLG)
                .stroke(Color.surfaceSecondary.opacity(0.3), lineWidth: 0.5)
        )
    }
    
    private func severityColor(for severity: OutageSeverity) -> Color {
        switch severity {
        case .minor: return .info
        case .moderate: return .warning
        case .major: return .statusMaintenance
        case .critical: return .error
        }
    }
}

#Preview {
    NavigationStack {
        CustomerHomeView()
    }
}
