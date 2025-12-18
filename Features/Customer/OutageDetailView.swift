import SwiftUI

struct OutageDetailView: View {
    let outage: Outage
    @State private var isSubscribed = false
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(severityColor(for: outage.severity))
                        
                        Text(outage.area)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        StatusBadge(text: outage.severity.rawValue, color: severityColor(for: outage.severity))
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        InfoCard(
                            icon: "doc.text.fill",
                            title: "Description",
                            value: outage.description,
                            color: .blue
                        )
                        
                        InfoCard(
                            icon: "wrench.fill",
                            title: "Cause",
                            value: outage.cause,
                            color: .orange
                        )
                        
                        InfoCard(
                            icon: "clock.fill",
                            title: "Started",
                            value: outage.startTime.formatted(date: .abbreviated, time: .shortened),
                            color: .purple
                        )
                        
                        if let estimatedEnd = outage.estimatedEndTime {
                            InfoCard(
                                icon: "clock.badge.checkmark.fill",
                                title: "Estimated End",
                                value: estimatedEnd.formatted(date: .abbreviated, time: .shortened),
                                color: .green
                            )
                        }
                        
                        InfoCard(
                            icon: "person.3.fill",
                            title: "Affected Customers",
                            value: "\(outage.affectedCustomers.formatted())",
                            color: .red
                        )
                    }
                    
                    AnimatedToggle(isOn: $isSubscribed, label: "Receive Updates")
                    
                    Button(action: {
                        withAnimation {
                            isSubscribed.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: isSubscribed ? "bell.fill" : "bell.slash.fill")
                            Text(isSubscribed ? "Unsubscribe from Updates" : "Subscribe to Updates")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isSubscribed ? Color.red : Color.primaryBlue)
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Outage Details")
        .navigationBarTitleDisplayMode(.inline)
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
        OutageDetailView(outage: Outage(area: "Nyarugenge", severity: .major, description: "Main pipeline maintenance", startTime: Date(), estimatedEndTime: Date().addingTimeInterval(7200), affectedCustomers: 5000, cause: "Scheduled Maintenance"))
    }
}

