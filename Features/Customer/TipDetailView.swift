import SwiftUI

struct TipDetailView: View {
    let tip: WaterTip
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Image(systemName: tip.icon)
                        // ... rest is same but tip.icon is now from struct

                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.primaryBlue)
                        
                        Text(tip.title)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textPrimary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Description")
                            .font(.headline)
                            .foregroundColor(.textSecondary)
                        
                        Text(tip.description)
                            .font(.body)
                            .foregroundColor(.textPrimary)
                            .lineSpacing(6)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.cardDark)
                    .cornerRadius(16)
                    
                    VStack(spacing: 16) {
                        InfoCard(
                            icon: "drop.fill",
                            title: "Potential Savings",
                            value: "Up to 30% reduction",
                            color: .green
                        )
                        
                        InfoCard(
                            icon: "clock.fill",
                            title: "Implementation Time",
                            value: "5-10 minutes",
                            color: .blue
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Tip Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
    TipDetailView(tip: WaterTip(title: "Fix Leaks Promptly", description: "A dripping faucet can waste up to 3,000 gallons per year.", category: "General", impact: "High", icon: "drop.triangle.fill"))
    }
}

