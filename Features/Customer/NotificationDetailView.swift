import SwiftUI

struct NotificationDetailView: View {
    let notification: NotificationItem
    @State private var isRead: Bool
    
    init(notification: NotificationItem) {
        self.notification = notification
        _isRead = State(initialValue: notification.isRead)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Image(systemName: iconForType(notification.type))
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(colorForType(notification.type))
                        
                        Text(notification.title)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textPrimary)
                            .multilineTextAlignment(.center)
                        
                        StatusBadge(text: notification.type.rawValue, color: colorForType(notification.type))
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Message")
                            .font(.headline)
                            .foregroundColor(.textSecondary)
                        
                        Text(notification.message)
                            .font(.body)
                            .foregroundColor(.textPrimary)
                            .lineSpacing(4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.cardDark)
                    .cornerRadius(16)
                    
                    if let area = notification.area {
                        InfoCard(
                            icon: "location.fill",
                            title: "Area",
                            value: area,
                            color: .blue
                        )
                    }
                    
                    InfoCard(
                        icon: "clock.fill",
                        title: "Received",
                        value: notification.timestamp.formatted(date: .abbreviated, time: .shortened),
                        color: .purple
                    )
                    
                    if notification.type == .outage {
                        NavigationLink(destination: OutageListView()) {
                            HStack {
                                Text("View Related Outages")
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
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Notification")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if !isRead {
                withAnimation {
                    isRead = true
                }
            }
        }
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
        NotificationDetailView(notification: NotificationItem(title: "Water Restored", message: "Water service has been restored", type: .update, area: "Kigali Central"))
    }
}

