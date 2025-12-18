import SwiftUI

struct ActiveOutagesView: View {
    @State private var outages: [Outage] = [
        Outage(area: "Nyarugenge", severity: .major, description: "Main pipeline maintenance in progress", startTime: Date().addingTimeInterval(-3600), estimatedEndTime: Date().addingTimeInterval(7200), affectedCustomers: 5000, cause: "Scheduled Maintenance"),
        Outage(area: "Gasabo", severity: .minor, description: "Low pressure reported in several zones", startTime: Date().addingTimeInterval(-1800), affectedCustomers: 1200, cause: "High Demand")
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            if outages.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                    
                    Text("No Active Outages")
                        .font(.title2)
                        .foregroundColor(.textPrimary)
                    
                    Text("All systems operational")
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(outages) { outage in
                            NavigationLink(destination: OutageDetailView(outage: outage)) {
                                AdminOutageCard(outage: outage)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct AdminOutageCard: View {
    let outage: Outage
    @State private var isResolved = false
    
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
            
            Divider()
                .background(Color.textSecondary.opacity(0.3))
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Affected")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                    
                    Text("\(outage.affectedCustomers.formatted())")
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
            
            Button(action: {
                withAnimation {
                    isResolved = true
                }
            }) {
                Text("Mark as Resolved")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isResolved ? Color.green : Color.primaryBlue)
                    .cornerRadius(12)
            }
            .disabled(isResolved)
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
    ActiveOutagesView()
}

