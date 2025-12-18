import SwiftUI

struct DailyUsageView: View {
    @State private var dailyData: [(hour: Int, usage: Double)] = [
        (0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (5, 2.5),
        (6, 8.5), (7, 15.0), (8, 12.5), (9, 8.0), (10, 6.5),
        (11, 7.0), (12, 9.5), (13, 8.0), (14, 6.5), (15, 7.5),
        (16, 9.0), (17, 11.5), (18, 14.0), (19, 10.5), (20, 8.0),
        (21, 5.5), (22, 3.0), (23, 1.5)
    ]
    
    @State private var selectedHour: Int? = nil
    @State private var totalUsage: Double = 125.5
    
    var maxUsage: Double {
        dailyData.map { $0.usage }.max() ?? 1
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    usageHeader
                    chartSection
                    infoCardsSection
                }
                .padding(.top)
            }
        }
        .navigationTitle("Daily Usage")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Sub-views
private extension DailyUsageView {
    
    var usageHeader: some View {
        VStack(spacing: 16) {
            Text("\(totalUsage, specifier: "%.1f") L")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.textPrimary)
            
            Text("Today's Total Usage")
                .font(.subheadline)
                .foregroundColor(.textSecondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.cardDark)
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    var chartSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hourly Breakdown")
                .font(.headline)
                .foregroundColor(.textPrimary)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(dailyData, id: \.hour) { data in
                        barComponent(for: data)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(Color.cardDark)
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func barComponent(for data: (hour: Int, usage: Double)) -> some View {
        // Breaking the math out into a constant helps the compiler
        let barHeight = CGFloat((data.usage / maxUsage) * 150)
        
        VStack(spacing: 8) {
            Rectangle()
                .fill(data.hour == selectedHour ? Color.primaryBlue : Color.blue.opacity(0.6))
                .frame(width: 20, height: max(4, barHeight))
                .cornerRadius(4)
                .onTapGesture {
                    withAnimation {
                        selectedHour = selectedHour == data.hour ? nil : data.hour
                    }
                }
            
            Text("\(data.hour)")
                .font(.caption2)
                .foregroundColor(.textSecondary)
        }
    }
    
    var infoCardsSection: some View {
        VStack(spacing: 16) {
            InfoCard(
                icon: "clock.fill",
                title: "Peak Hour",
                value: "7:00 AM - 8:00 AM",
                color: .orange
            )
            
            InfoCard(
                icon: "drop.fill",
                title: "Average per Hour",
                value: "\((totalUsage / 24).formatted(.number.precision(.fractionLength(1)))) L",
                color: .blue
            )
        }
        .padding(.horizontal)
    }
}
