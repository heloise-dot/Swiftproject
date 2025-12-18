import SwiftUI

struct AreaManagementView: View {
    @State private var areas: [Area] = [
        Area(name: "Kigali Central", status: .available, population: 50000, waterSource: "Main Reservoir"),
        Area(name: "Gasabo", status: .lowPressure, population: 35000, waterSource: "Pump Station A"),
        Area(name: "Nyarugenge", status: .outage, population: 40000, waterSource: "Treatment Plant"),
        Area(name: "Kicukiro", status: .available, population: 30000, waterSource: "Well System"),
        Area(name: "Kimisagara", status: .available, population: 25000, waterSource: "Reservoir B"),
        Area(name: "Remera", status: .scheduledMaintenance, population: 28000, waterSource: "Pump Station B")
    ]
    
    @State private var searchText = ""
    
    var filteredAreas: [Area] {
        if searchText.isEmpty {
            return areas
        }
        return areas.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.textSecondary)
                    
                    TextField("Search areas...", text: $searchText)
                        .foregroundColor(.textPrimary)
                }
                .padding()
                .background(Color.cardDark)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredAreas) { area in
                            NavigationLink(value: AppRoute.editAreaStatus(area)) {
                                AdminAreaRowView(area: area)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Area Management")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct AdminAreaRowView: View {
    let area: Area
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(area.name)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                HStack(spacing: 16) {
                    Label("\(area.population.formatted())", systemImage: "person.3.fill")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                    
                    Label(area.waterSource, systemImage: "drop.fill")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                StatusBadge(text: area.status.rawValue, color: statusColor(for: area.status))
                
                Text(area.lastUpdated, style: .relative)
                    .font(.caption2)
                    .foregroundColor(.textSecondary)
            }
            
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
    NavigationStack {
        AreaManagementView()
    }
}

