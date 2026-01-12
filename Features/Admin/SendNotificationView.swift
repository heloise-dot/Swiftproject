import SwiftUI

struct SendNotificationView: View {
    @State private var selectedType: NotificationType = .update
    @State private var title = ""
    @State private var message = ""
    @State private var selectedArea: String? = nil
    @State private var isSending = false
    @State private var isSent = false
    
    let areas = ["Kigali Central", "Gasabo", "Nyarugenge", "Kicukiro", "Kimisagara", "Remera", "All Areas"]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            if isSent {
                VStack(spacing: 24) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green)
                    
                    Text("Notification Sent!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.textPrimary)
                    
                    Text("All users have been notified")
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                    
                    PrimaryButton(title: "Send Another") {
                        withAnimation {
                            isSent = false
                            title = ""
                            message = ""
                            selectedArea = nil
                        }
                    }
                }
                .padding()
                .transition(.scale.combined(with: .opacity))
            } else {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Notification Type")
                                .font(.headline)
                                .foregroundColor(.textPrimary)
                            
                            VStack(spacing: 12) {
                                ForEach(NotificationType.allCases, id: \.self) { type in
                                    NotificationTypeButton(
                                        type: type,
                                        isSelected: selectedType == type
                                    ) {
                                        withAnimation {
                                            selectedType = type
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.cardDark)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Title")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            TextField("Enter title", text: $title)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(12)
                                .foregroundColor(.textPrimary)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Message")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            TextEditor(text: $message)
                                .frame(height: 150)
                                .padding(8)
                                .background(Color.cardDark)
                                .cornerRadius(12)
                                .foregroundColor(.textPrimary)
                                .scrollContentBackground(.hidden)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Target Area (Optional)")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            Picker("Area", selection: Binding(
                                get: { selectedArea ?? "All Areas" },
                                set: { selectedArea = $0 == "All Areas" ? nil : $0 }
                            )) {
                                ForEach(areas, id: \.self) { area in
                                    Text(area).tag(area)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                            .foregroundColor(.textPrimary)
                        }
                        .padding(.horizontal)
                        
                        NavigationLink(value: AppRoute.notificationHistory) {
                            HStack {
                                Text("View Notification History")
                                    .font(.headline)
                                    .foregroundColor(.textPrimary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.textSecondary)
                            }
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(16)
                        }
                        .buttonStyle(.interactive)
                        .padding(.horizontal)
                        
                        PrimaryButton(title: "Send Notification") {
                            withAnimation {
                                isSending = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    isSending = false
                                    isSent = true
                                }
                            }
                        }
                        .disabled(isSending || title.isEmpty || message.isEmpty)
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationTitle("Send Notification")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct NotificationTypeButton: View {
    let type: NotificationType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconForType(type))
                    .foregroundColor(isSelected ? colorForType(type) : .textSecondary)
                
                Text(type.rawValue)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(colorForType(type))
                }
            }
            .padding()
            .background(isSelected ? colorForType(type).opacity(0.1) : Color.clear)
            .cornerRadius(12)
        }
        .buttonStyle(.interactive)
    }
    
    private func iconForType(_ type: NotificationType) -> String {
        switch type {
        case .outage: return "exclamationmark.triangle.fill"
        case .maintenance: return "wrench.fill"
        case .update: return "checkmark.circle.fill"
        case .tip: return "lightbulb.fill"
        case .emergency: return "bell.fill"
        }
    }
    
    private func colorForType(_ type: NotificationType) -> Color {
        switch type {
        case .outage: return .red
        case .maintenance: return .orange
        case .update: return .green
        case .tip: return .blue
        case .emergency: return .red
        }
    }
}

#Preview {
    NavigationStack {
        SendNotificationView()
    }
}

