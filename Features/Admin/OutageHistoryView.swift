import SwiftUI

struct OutageHistoryView: View {
    @State private var resolvedOutages: [Outage] = [
        Outage(area: "Kicukiro", severity: .critical, description: "Emergency repair completed", startTime: Date().addingTimeInterval(-86400), estimatedEndTime: Date().addingTimeInterval(-72000), isResolved: true, affectedCustomers: 8000, cause: "Pipe Burst"),
        Outage(area: "Kimisagara", severity: .moderate, description: "Pump station maintenance completed", startTime: Date().addingTimeInterval(-172800), estimatedEndTime: Date().addingTimeInterval(-108000), isResolved: true, affectedCustomers: 3000, cause: "Routine Maintenance"),
        Outage(area: "Remera", severity: .minor, description: "Low pressure issue resolved", startTime: Date().addingTimeInterval(-259200), estimatedEndTime: Date().addingTimeInterval(-216000), isResolved: true, affectedCustomers: 1500, cause: "High Demand")
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            if resolvedOutages.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.textSecondary)
                    
                    Text("No History")
                        .font(.title2)
                        .foregroundColor(.textPrimary)
                    
                    Text("Resolved outages will appear here")
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(resolvedOutages) { outage in
                            NavigationLink(destination: OutageDetailView(outage: outage)) {
                                HistoryOutageCard(outage: outage)
                            }
                            .buttonStyle(.interactive)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct HistoryOutageCard: View {
    let outage: Outage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(outage.area)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                StatusBadge(text: "Resolved", color: .green)
            }
            
            Text(outage.description)
                .font(.subheadline)
                .foregroundColor(.textSecondary)
            
            HStack {
                Label("\(outage.affectedCustomers.formatted()) customers", systemImage: "person.3.fill")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                
                Spacer()
                
                Text(outage.startTime, style: .date)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
    }
}

#Preview {
    OutageHistoryView()
}

