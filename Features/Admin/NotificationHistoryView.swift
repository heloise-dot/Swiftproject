import SwiftUI

struct NotificationHistoryView: View {
    @State private var notifications: [NotificationItem] = [
        NotificationItem(title: "Water Restored", message: "Water service has been restored in Kigali Central", type: .update, timestamp: Date().addingTimeInterval(-300), area: "Kigali Central"),
        NotificationItem(title: "Scheduled Maintenance", message: "Maintenance scheduled for tomorrow", type: .maintenance, timestamp: Date().addingTimeInterval(-1800), area: "Gasabo"),
        NotificationItem(title: "Water Saving Tip", message: "Fix leaks promptly to save water", type: .tip, timestamp: Date().addingTimeInterval(-3600)),
        NotificationItem(title: "Outage Alert", message: "Water outage reported in Nyarugenge", type: .outage, timestamp: Date().addingTimeInterval(-7200), area: "Nyarugenge"),
        NotificationItem(title: "Emergency Update", message: "Emergency repair in progress", type: .emergency, timestamp: Date().addingTimeInterval(-10800), area: "Kicukiro")
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            if notifications.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "bell.slash.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.textSecondary)
                    
                    Text("No Notifications Sent")
                        .font(.title2)
                        .foregroundColor(.textPrimary)
                    
                    Text("Notification history will appear here")
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(notifications) { notification in
                            NavigationLink(value: AppRoute.notificationDetail(notification)) {
                                AdminNotificationCard(notification: notification)
                            }
                            .buttonStyle(.interactive)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Notification History")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct AdminNotificationCard: View {
    let notification: NotificationItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: iconForType(notification.type))
                    .foregroundColor(colorForType(notification.type))
                    .frame(width: 40, height: 40)
                    .background(colorForType(notification.type).opacity(0.2))
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(notification.title)
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                    
                    Text(notification.type.rawValue)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
                
                Text(notification.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
            
            Text(notification.message)
                .font(.subheadline)
                .foregroundColor(.textSecondary)
            
            if let area = notification.area {
                HStack {
                    Image(systemName: "location.fill")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                    
                    Text(area)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
            }
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(16)
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
        NotificationHistoryView()
    }
}

