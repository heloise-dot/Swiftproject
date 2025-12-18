import SwiftUI

struct PumpControlView: View {
    @State private var pumps: [(name: String, isActive: Bool, pressure: Double)] = [
        ("Pump Station A", true, 4.5),
        ("Pump Station B", false, 0.0),
        ("Pump Station C", true, 3.8),
        ("Pump Station D", true, 5.2)
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        SectionHeader(title: "Pump Stations")
                        
                        ForEach(Array(pumps.enumerated()), id: \.offset) { index, pump in
                            PumpCard(
                                name: pump.name,
                                isActive: Binding(
                                    get: { pump.isActive },
                                    set: { newValue in
                                        withAnimation {
                                            pumps[index].isActive = newValue
                                        }
                                    }
                                ),
                                pressure: pump.pressure
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack(spacing: 16) {
                        InfoCard(
                            icon: "chart.bar.fill",
                            title: "Active Pumps",
                            value: "\(pumps.filter { $0.isActive }.count) / \(pumps.count)",
                            color: .green
                        )
                        
                        InfoCard(
                            icon: "gauge.high",
                            title: "Average Pressure",
                            value: "\(String(format: "%.1f", pumps.filter { $0.isActive }.map { $0.pressure }.reduce(0, +) / Double(max(1, pumps.filter { $0.isActive }.count)))) bar",
                            color: .blue
                        )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Pump Control")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PumpCard: View {
    let name: String
    @Binding var isActive: Bool
    let pressure: Double
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                    
                    Text("Pressure: \(pressure, specifier: "%.1f") bar")
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
                
                StatusBadge(text: isActive ? "Active" : "Inactive", color: isActive ? .green : .red)
            }
            
            AnimatedToggle(isOn: $isActive, label: "Power")
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
    }
}

#Preview {
    NavigationStack {
        PumpControlView()
    }
}

