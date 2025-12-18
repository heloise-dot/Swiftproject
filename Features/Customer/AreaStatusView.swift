import SwiftUI

struct AreaStatusView: View {
    let area: Area
    @State private var isRefreshing = false
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Image(systemName: statusIcon(for: area.status))
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(statusColor(for: area.status))
                            .symbolEffect(.pulse, options: .repeating)
                        
                        Text(area.name)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        StatusBadge(text: area.status.rawValue, color: statusColor(for: area.status))
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        InfoCard(
                            icon: "drop.fill",
                            title: "Water Source",
                            value: area.waterSource,
                            color: .blue
                        )
                        
                        InfoCard(
                            icon: "person.3.fill",
                            title: "Population",
                            value: "\(area.population.formatted()) people",
                            color: .purple
                        )
                        
                        InfoCard(
                            icon: "clock.fill",
                            title: "Last Updated",
                            value: area.lastUpdated.formatted(date: .abbreviated, time: .shortened),
                            color: .orange
                        )
                    }
                    
                    if area.status == .outage {
                        NavigationLink(destination: OutageListView()) {
                            HStack {
                                Text("View Active Outages")
                                    .font(.headline)
                                    .foregroundColor(.textPrimary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.textSecondary)
                            }
                            .padding()
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(16)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Button(action: {
                        withAnimation {
                            isRefreshing = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation {
                                isRefreshing = false
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .rotationEffect(.degrees(isRefreshing ? 360 : 0))
                                .animation(isRefreshing ? .linear(duration: 1.0).repeatForever(autoreverses: false) : .default, value: isRefreshing)
                            
                            Text("Refresh Status")
                                .font(.headline)
                        }
                        .foregroundColor(.primaryBlue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cardDark)
                        .cornerRadius(16)
                    }
                    .disabled(isRefreshing)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Area Status")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func statusColor(for status: WaterStatus) -> Color {
        switch status {
        case .available: return .green
        case .lowPressure: return .yellow
        case .scheduledMaintenance: return .orange
        case .outage: return .red
        }
    }
    
    private func statusIcon(for status: WaterStatus) -> String {
        switch status {
        case .available: return "checkmark.circle.fill"
        case .lowPressure: return "exclamationmark.triangle.fill"
        case .scheduledMaintenance: return "wrench.fill"
        case .outage: return "xmark.circle.fill"
        }
    }
}

#Preview {
    NavigationStack {
        AreaStatusView(area: Area(name: "Kigali Central", status: .available, population: 50000, waterSource: "Main Reservoir"))
    }
}

