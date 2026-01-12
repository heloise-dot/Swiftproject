import SwiftUI

struct WaterSourceDetailView: View {
    let source: WaterSource
    @State private var isActive: Bool
    @State private var currentLevel: Double
    
    init(source: WaterSource) {
        self.source = source
        _isActive = State(initialValue: source.isActive)
        _currentLevel = State(initialValue: source.currentLevel)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Image(systemName: iconForType(source.type))
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.primaryBlue)
                        
                        Text(source.name)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        StatusBadge(text: source.type.rawValue, color: .blue)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        InfoCard(
                            icon: "location.fill",
                            title: "Location",
                            value: source.location,
                            color: .purple
                        )
                        
                        InfoCard(
                            icon: "drop.fill",
                            title: "Capacity",
                            value: "\(Int(source.capacity)) L",
                            color: .blue
                        )
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Current Level")
                                    .font(.headline)
                                    .foregroundColor(.textPrimary)
                                
                                Spacer()
                                
                                Text("\(Int((currentLevel / source.capacity) * 100))%")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(levelColor(for: (currentLevel / source.capacity) * 100))
                            }
                            
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color.textSecondary.opacity(0.2))
                                        .frame(height: 12)
                                        .cornerRadius(6)
                                    
                                    Rectangle()
                                        .fill(levelColor(for: (currentLevel / source.capacity) * 100))
                                        .frame(width: geometry.size.width * CGFloat(currentLevel / source.capacity), height: 12)
                                        .cornerRadius(6)
                                }
                            }
                            .frame(height: 12)
                            
                            Text("\(Int(currentLevel)) / \(Int(source.capacity)) L")
                                .font(.caption)
                                .foregroundColor(.textSecondary)
                        }
                        .padding()
                        .background(Color.cardDark)
                        .cornerRadius(16)
                        
                        AnimatedToggle(isOn: $isActive, label: "Active Status")
                        
                        InfoCard(
                            icon: "wrench.fill",
                            title: "Last Maintenance",
                            value: source.lastMaintenance.formatted(date: .abbreviated, time: .shortened),
                            color: .orange
                        )
                    }
                    
                    NavigationLink(destination: PumpControlView()) {
                        HStack {
                            Text("Control Pumps")
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
                    
                    NavigationLink(destination: TankLevelView()) {
                        HStack {
                            Text("Tank Levels")
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
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Water Source")
        .navigationBarTitleDisplayMode(.inline)
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
        WaterSourceDetailView(source: WaterSource(name: "Main Reservoir", type: .reservoir, capacity: 50000, currentLevel: 42000, isActive: true, location: "Kigali Central"))
    }
}

