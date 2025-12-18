import SwiftUI

struct AnimatedToggle: View {
    @Binding var isOn: Bool
    let label: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.textPrimary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .primaryBlue))
                .labelsHidden()
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(12)
    }
}

