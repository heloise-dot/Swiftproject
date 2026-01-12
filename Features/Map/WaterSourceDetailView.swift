import SwiftUI
import CoreLocation

struct WaterSourceDetailView: View {
    let waterSource: MapWaterSource
    var onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Drag Indicator
            Capsule()
                .fill(Color.textSecondary.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 16)
            
            // Header
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(waterSource.name)
                        .font(.heading2)
                        .foregroundColor(.textPrimary)
                    
                    Text(waterSource.type.rawValue)
                        .font(.bodyMedium)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
                
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.textTertiary)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
            
            // Status Cards
            HStack(spacing: 12) {
                StatusInfoCard(
                    title: "Status",
                    value: waterSource.status.rawValue,
                    icon: "waveform.path.ecg",
                    color: waterSource.status.color
                )
                
                StatusInfoCard(
                    title: "Quality",
                    value: waterSource.quality,
                    icon: "drop.fill",
                    color: .primaryTeal
                )
                
                StatusInfoCard(
                    title: "Flow",
                    value: waterSource.flowRateDisplay,
                    icon: "wind",
                    color: .primaryBlue
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
            
            // Additional Info
            VStack(alignment: .leading, spacing: 12) {
                Text("Current Conditions")
                    .font(.heading3)
                    .foregroundColor(.textPrimary)
                
                HStack(spacing: 12) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(waterSource.status.color)
                    
                    Text(waterSource.status.description)
                        .font(.bodyMedium)
                        .foregroundColor(.textSecondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.cardDark)
                .cornerRadius(.radiusMD)
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .background(Color.backgroundDark)
        .cornerRadius(.radiusXL, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: -5)
    }
}

struct StatusInfoCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.15))
                .clipShape(Circle())
            
            VStack(spacing: 4) {
                Text(value)
                    .font(.labelMedium)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color.cardDark)
        .cornerRadius(.radiusMD)
    }
}

// Extension to support specific corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners


    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


