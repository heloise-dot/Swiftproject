import SwiftUI

struct MonthlyUsageView: View {
    @State private var monthlyData: [(month: String, usage: Double)] = [
        ("Jan", 3200), ("Feb", 3100), ("Mar", 3400),
        ("Apr", 3300), ("May", 3600), ("Jun", 3500),
        ("Jul", 3800), ("Aug", 3700), ("Sep", 3400),
        ("Oct", 3300), ("Nov", 3100), ("Dec", 3000)
    ]
    
    @State private var selectedMonth: String? = nil
    @State private var currentMonthUsage: Double = 3765.0
    
    var maxUsage: Double {
        monthlyData.map { $0.usage }.max() ?? 1
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Text("\(Int(currentMonthUsage)) L")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        Text("This Month's Total")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                        
                        Text("Average: \(Int(currentMonthUsage / 30)) L/day")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.cardDark)
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Yearly Overview")
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .bottom, spacing: 8) {
                                ForEach(monthlyData, id: \.month) { data in
                                    VStack(spacing: 12) {
                                        Rectangle()
                                            .fill(selectedMonth == data.month ? Color.purple : Color.purple.opacity(0.6))
                                            .frame(width: 25, height: max(4, CGFloat(data.usage / maxUsage * 150)))
                                            .cornerRadius(4)
                                            .onTapGesture {
                                                withAnimation {
                                                    selectedMonth = selectedMonth == data.month ? nil : data.month
                                                }
                                            }
                                        
                                        VStack(spacing: 4) {
                                            Text("\(Int(data.usage / 1000))k")
                                                .font(.caption2)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.textPrimary)
                                            
                                            Text(data.month)
                                                .font(.caption2)
                                                .foregroundColor(.textSecondary)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                    .background(Color.cardDark)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        InfoCard(
                            icon: "chart.line.uptrend.xyaxis",
                            title: "Trend",
                            value: "Decreasing",
                            color: .green
                        )
                        
                        InfoCard(
                            icon: "trophy.fill",
                            title: "Best Month",
                            value: "December: 3,000 L",
                            color: .yellow
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
        }
        .navigationTitle("Monthly Usage")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MonthlyUsageView()
    }
}

