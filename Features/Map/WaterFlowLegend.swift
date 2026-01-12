import SwiftUI

struct WaterFlowLegend: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Flow Status")
                .font(.labelSmall)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .padding(.bottom, 4)
            
            ForEach(WaterFlowStatus.allCases, id: \.self) { status in
                HStack(spacing: 8) {
                    Circle()
                        .fill(status.color)
                        .frame(width: 10, height: 10)
                    
                    Text(status.rawValue)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
            }
        }
        .padding(12)
        .background(Color.cardDark.opacity(0.95))
        .cornerRadius(.radiusMD)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}
