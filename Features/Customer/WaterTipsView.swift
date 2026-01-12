import SwiftUI

struct WaterTipsView: View {
    @State private var tips: [WaterTip] = [
        WaterTip(title: "Fix Leaks Promptly", description: "A dripping faucet can waste up to 3,000 gallons per year. Fix leaks immediately to save water and money.", category: "General", impact: "High", icon: "drop.triangle.fill"),
        WaterTip(title: "Use Efficient Fixtures", description: "Install low-flow showerheads and faucets to reduce water consumption by up to 50%.", category: "Fixture", impact: "Medium", icon: "faucet.fill"),
        WaterTip(title: "Take Shorter Showers", description: "Reducing shower time by just 2 minutes can save up to 1,750 gallons per year.", category: "Personal", impact: "Medium", icon: "shower.fill"),
        WaterTip(title: "Water Plants Wisely", description: "Water your garden early morning or evening to reduce evaporation. Use a watering can instead of a hose.", category: "Garden", impact: "Medium", icon: "leaf.fill"),
        WaterTip(title: "Full Loads Only", description: "Run dishwashers and washing machines only with full loads to maximize water efficiency.", category: "Appliance", impact: "High", icon: "washer.fill"),
        WaterTip(title: "Collect Rainwater", description: "Use rain barrels to collect rainwater for watering plants and cleaning.", category: "Garden", impact: "High", icon: "cloud.rain.fill"),
        WaterTip(title: "Turn Off Tap", description: "Turn off the tap while brushing teeth or washing dishes to save gallons daily.", category: "Personal", impact: "Medium", icon: "hand.raised.fill"),
        WaterTip(title: "Check for Leaks", description: "Regularly check pipes, toilets, and faucets for leaks. A running toilet can waste 200 gallons per day.", category: "General", impact: "High", icon: "magnifyingglass")
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(Array(tips.enumerated()), id: \.offset) { index, tip in
                        NavigationLink(value: AppRoute.tipDetail(tip)) {
                            TipCardView(tip: tip, index: index)
                        }
                        .buttonStyle(.interactive)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Water Saving Tips")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct TipCardView: View {
    let tip: WaterTip
    let index: Int
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: tip.icon)
                .font(.title2)
                .foregroundColor(.primaryBlue)
                .frame(width: 50, height: 50)
                .background(Color.primaryBlue.opacity(0.2))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(tip.title)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Text(tip.description)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
                    .lineLimit(2)
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
    NavigationStack {
        WaterTipsView()
    }
}

