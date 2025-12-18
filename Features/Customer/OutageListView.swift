import SwiftUI

struct OutageListView: View {
    @State private var outages: [Outage] = [
        Outage(area: "Nyarugenge", severity: .major, description: "Main pipeline maintenance in progress", startTime: Date().addingTimeInterval(-3600), estimatedEndTime: Date().addingTimeInterval(7200), affectedCustomers: 5000, cause: "Scheduled Maintenance"),
        Outage(area: "Gasabo", severity: .minor, description: "Low pressure reported in several zones", startTime: Date().addingTimeInterval(-1800), affectedCustomers: 1200, cause: "High Demand"),
        Outage(area: "Kicukiro", severity: .critical, description: "Emergency repair required", startTime: Date().addingTimeInterval(-7200), estimatedEndTime: Date().addingTimeInterval(10800), affectedCustomers: 8000, cause: "Pipe Burst"),
        Outage(area: "Kimisagara", severity: .moderate, description: "Pump station maintenance", startTime: Date().addingTimeInterval(-5400), estimatedEndTime: Date().addingTimeInterval(9000), affectedCustomers: 3000, cause: "Routine Maintenance")
    ]
    
    @State private var selectedFilter: OutageSeverity? = nil
    
    var filteredOutages: [Outage] {
        if let filter = selectedFilter {
            return outages.filter { $0.severity == filter && !$0.isResolved }
        }
        return outages.filter { !$0.isResolved }
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        FilterButton(title: "All", isSelected: selectedFilter == nil) {
                            withAnimation {
                                selectedFilter = nil
                            }
                        }
                        
                        ForEach(OutageSeverity.allCases, id: \.self) { severity in
                            FilterButton(title: severity.rawValue, isSelected: selectedFilter == severity) {
                                withAnimation {
                                    selectedFilter = severity
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredOutages) { outage in
                            NavigationLink(value: AppRoute.outageDetail(outage)) {
                                OutageCardView(outage: outage)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Active Outages")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(isSelected ? .white : .textSecondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.primaryBlue : Color.cardDark)
                .cornerRadius(20)
        }
    }
}

struct OutageCardView: View {
    let outage: Outage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(outage.area)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                StatusBadge(text: outage.severity.rawValue, color: severityColor(for: outage.severity))
            }
            
            Text(outage.description)
                .font(.subheadline)
                .foregroundColor(.textSecondary)
                .lineLimit(2)
            
            Divider()
                .background(Color.textSecondary.opacity(0.3))
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Affected")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                    
                    Text("\(outage.affectedCustomers.formatted()) customers")
                        .font(.subheadline)
                        .foregroundColor(.textPrimary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Started")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                    
                    Text(outage.startTime, style: .relative)
                        .font(.subheadline)
                        .foregroundColor(.textPrimary)
                }
            }
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
    NavigationStack {
        OutageListView()
    }
}

