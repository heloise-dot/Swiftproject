import SwiftUI

struct WaterSourceListView: View {
    @State private var waterSources: [WaterSource] = [
        WaterSource(name: "Main Reservoir", type: .reservoir, capacity: 50000, currentLevel: 42000, isActive: true, location: "Kigali Central"),
        WaterSource(name: "Pump Station A", type: .pump, capacity: 30000, currentLevel: 28000, isActive: true, location: "Gasabo"),
        WaterSource(name: "Treatment Plant", type: .treatment, capacity: 40000, currentLevel: 35000, isActive: true, location: "Nyarugenge"),
        WaterSource(name: "Well System", type: .well, capacity: 20000, currentLevel: 15000, isActive: true, location: "Kicukiro"),
        WaterSource(name: "Reservoir B", type: .reservoir, capacity: 25000, currentLevel: 18000, isActive: false, location: "Kimisagara")
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(waterSources) { source in
                        NavigationLink(value: AppRoute.waterSourceDetail(source)) {
                            WaterSourceRowView(source: source)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Water Sources")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct WaterSourceRowView: View {
    let source: WaterSource
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(source.name)
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                    
                    Text(source.location)
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
                
                StatusBadge(text: source.isActive ? "Active" : "Inactive", color: source.isActive ? .green : .red)
            }
            
            HStack {
                Label(source.type.rawValue, systemImage: iconForType(source.type))
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                
                Spacer()
                
                Text("\(Int(source.levelPercentage))%")
                    .font(.headline)
                    .foregroundColor(.textPrimary)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.textSecondary.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(levelColor(for: source.levelPercentage))
                        .frame(width: geometry.size.width * CGFloat(source.levelPercentage / 100), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
    }
    
    private func iconForType(_ type: SourceType) -> String {
        switch type {
        case .reservoir: return "drop.fill"
        case .well: return "circle.fill"
        case .pump: return "gearshape.fill"
        case .treatment: return "flask.fill"
        }
    }
    
    private func levelColor(for percentage: Double) -> Color {
        if percentage > 70 {
            return .green
        } else if percentage > 40 {
            return .yellow
        } else {
            return .red
        }
    }
}

#Preview {
    NavigationStack {
        WaterSourceListView()
    }
}

