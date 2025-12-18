import SwiftUI

struct TankLevelView: View {
    @State private var tanks: [(name: String, level: Double, capacity: Double)] = [
        ("Tank A", 42000, 50000),
        ("Tank B", 28000, 30000),
        ("Tank C", 35000, 40000),
        ("Tank D", 15000, 20000)
    ]
    
    // MARK: - Computed Properties for Math
    private var totalCapacity: Double {
        tanks.map { $0.capacity }.reduce(0, +)
    }
    
    private var totalCurrentLevel: Double {
        tanks.map { $0.level }.reduce(0, +)
    }
    
    private var overallPercentage: Int {
        guard totalCapacity > 0 else { return 0 }
        return Int((totalCurrentLevel / totalCapacity) * 100)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Tank Cards Section
                    VStack(spacing: 16) {
                        SectionHeader(title: "Tank Levels")
                        
                        ForEach(Array(tanks.enumerated()), id: \.offset) { index, tank in
                            TankCard(
                                name: tank.name,
                                level: tank.level,
                                capacity: tank.capacity
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Summary Info Cards
                    summarySection
                }
            }
        }
        .navigationTitle("Tank Levels")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Breaking the summary into its own view also helps the compiler
    private var summarySection: some View {
        VStack(spacing: 16) {
            InfoCard(
                icon: "drop.fill",
                title: "Total Capacity",
                value: "\(Int(totalCapacity)) L",
                color: .blue
            )
            
            InfoCard(
                icon: "chart.bar.fill",
                title: "Total Current",
                value: "\(Int(totalCurrentLevel)) L",
                color: .green
            )
            
            InfoCard(
                icon: "percent",
                title: "Overall Level",
                value: "\(overallPercentage)%",
                color: .purple
            )
        }
        .padding(.horizontal)
        .padding(.bottom, 40)
    }
}

// MARK: - Supporting Views

struct TankCard: View {
    let name: String
    let level: Double
    let capacity: Double
    
    var percentage: Double {
        guard capacity > 0 else { return 0 }
        return (level / capacity) * 100
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                Text("\(Int(percentage))%")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(levelColor(for: percentage))
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.textSecondary.opacity(0.2))
                        .frame(height: 16)
                        .cornerRadius(8)
                    
                    Rectangle()
                        .fill(levelColor(for: percentage))
                        .frame(width: geometry.size.width * CGFloat(percentage / 100), height: 16)
                        .cornerRadius(8)
                }
            }
            .frame(height: 16)
            
            Text("\(Int(level)) / \(Int(capacity)) L")
                .font(.caption)
                .foregroundColor(.textSecondary)
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
    }
    
    private func levelColor(for percentage: Double) -> Color {
        if percentage > 70 { return .green }
        if percentage > 40 { return .yellow }
        return .red
    }
}



