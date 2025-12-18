import SwiftUI

struct WeeklyUsageView: View {
    @State private var weeklyData: [(day: String, usage: Double)] = [
        ("Mon", 120.5), ("Tue", 135.0), ("Wed", 128.5),
        ("Thu", 142.0), ("Fri", 138.5), ("Sat", 115.0), ("Sun", 99.5)
    ]
    
    @State private var selectedDay: String? = nil
    @State private var totalUsage: Double = 879.0
    
    var maxUsage: Double {
        weeklyData.map { $0.usage }.max() ?? 1
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Text("\(Int(totalUsage)) L")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        Text("This Week's Total")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                        
                        Text("Average: \(Int(totalUsage / 7)) L/day")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.cardDark)
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Daily Breakdown")
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                            .padding(.horizontal)
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            ForEach(weeklyData, id: \.day) { data in
                                VStack(spacing: 12) {
                                    Rectangle()
                                        .fill(selectedDay == data.day ? Color.green : Color.green.opacity(0.6))
                                        .frame(width: 35, height: max(4, CGFloat(data.usage / maxUsage * 200)))
                                        .cornerRadius(8)
                                        .onTapGesture {
                                            withAnimation {
                                                selectedDay = selectedDay == data.day ? nil : data.day
                                            }
                                        }
                                    
                                    VStack(spacing: 4) {
                                        Text("\(Int(data.usage))")
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.textPrimary)
                                        
                                        Text(data.day)
                                            .font(.caption2)
                                            .foregroundColor(.textSecondary)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .padding(.vertical)
                    .background(Color.cardDark)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    if let selected = selectedDay, let data = weeklyData.first(where: { $0.day == selected }) {
                        VStack(spacing: 16) {
                            InfoCard(
                                icon: "calendar",
                                title: "Selected Day",
                                value: "\(data.day): \(Int(data.usage)) L",
                                color: .green
                            )
                        }
                        .padding(.horizontal)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .padding(.top)
            }
        }
        .navigationTitle("Weekly Usage")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        WeeklyUsageView()
    }
}

