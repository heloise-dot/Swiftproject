import SwiftUI

struct StatusCard: View {
    let area: String
    let status: String
    let color: Color

    @State private var animate = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(area)
                .font(.title3)
                .bold()
                .foregroundColor(.textPrimary)

            Text(status)
                .font(.headline)
                .padding(.vertical, 6)
                .padding(.horizontal, 14)
                .background(color.opacity(0.2))
                .foregroundColor(color)
                .cornerRadius(20)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cardDark)
        .cornerRadius(18)
        .opacity(animate ? 1 : 0)
        .offset(y: animate ? 0 : 20)
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                animate = true
            }
        }
    }
}



