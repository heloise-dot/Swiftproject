import SwiftUI

struct UsageOverviewView: View {
    @State private var selectedPeriod: UsagePeriod = .daily
    @State private var currentUsage: Double = 125.5
    @State private var averageUsage: Double = 140.0
    
    enum UsagePeriod: String, CaseIterable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
    }
    
    var body: some View {
        // NavigationStack removed to avoid nesting
            ZStack {
                Color.backgroundDark.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            Text("\(Int(currentUsage))")
                                .font(.system(size: 64, weight: .bold))
                                .foregroundColor(.textPrimary)
                            
                            Text("Liters Used")
                                .font(.title3)
                                .foregroundColor(.textSecondary)
                            
                            HStack(spacing: 8) {
                                Image(systemName: currentUsage < averageUsage ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                                    .foregroundColor(currentUsage < averageUsage ? .green : .red)
                                
                                Text("\(currentUsage < averageUsage ? "Below" : "Above") average by \(Int(abs(currentUsage - averageUsage)))L")
                                    .font(.subheadline)
                                    .foregroundColor(.textSecondary)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.cardDark)
                        .cornerRadius(20)
                        
                        Picker("Period", selection: $selectedPeriod) {
                            ForEach(UsagePeriod.allCases, id: \.self) { period in
                                Text(period.rawValue).tag(period)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            NavigationLink(value: AppRoute.dailyUsage) {
                                UsagePeriodCard(
                                    title: "Daily Usage",
                                    value: "125.5 L",
                                    icon: "calendar",
                                    color: .blue
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(value: AppRoute.weeklyUsage) {
                                UsagePeriodCard(
                                    title: "Weekly Usage",
                                    value: "878.5 L",
                                    icon: "chart.bar.fill",
                                    color: .green
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(value: AppRoute.monthlyUsage) {
                                UsagePeriodCard(
                                    title: "Monthly Usage",
                                    value: "3,765 L",
                                    icon: "calendar.badge.clock",
                                    color: .purple
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                        
                        NavigationLink(value: AppRoute.waterTips) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Water Saving Tips")
                                        .font(.headline)
                                        .foregroundColor(.textPrimary)
                                    
                                    Text("Learn how to reduce your water consumption")
                                        .font(.subheadline)
                                        .foregroundColor(.textSecondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "lightbulb.fill")
                                    .font(.title2)
                                    .foregroundColor(.yellow)
                            }
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(16)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Water Usage")
            .navigationBarTitleDisplayMode(.large)
    }
}

struct UsagePeriodCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(color.opacity(0.2))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Text(value)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.textSecondary)
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
    }
}

#Preview {
    UsageOverviewView()
}

