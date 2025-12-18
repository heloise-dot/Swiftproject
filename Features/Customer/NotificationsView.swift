import SwiftUI

struct NotificationsView: View {
    @State private var notifications: [NotificationItem] = [
        NotificationItem(title: "Water Restored", message: "Water service has been restored in your area", type: .update, timestamp: Date().addingTimeInterval(-300), area: "Kigali Central"),
        NotificationItem(title: "Scheduled Maintenance", message: "Maintenance scheduled for tomorrow 8 AM - 12 PM", type: .maintenance, timestamp: Date().addingTimeInterval(-1800), area: "Gasabo"),
        NotificationItem(title: "Water Saving Tip", message: "Fix leaks promptly to save water and reduce bills", type: .tip, timestamp: Date().addingTimeInterval(-3600)),
        NotificationItem(title: "Outage Alert", message: "Water outage reported in Nyarugenge area", type: .outage, timestamp: Date().addingTimeInterval(-7200), area: "Nyarugenge"),
        NotificationItem(title: "Emergency Update", message: "Emergency repair in progress", type: .emergency, timestamp: Date().addingTimeInterval(-10800), area: "Kicukiro")
    ]
    
    @State private var selectedFilter: NotificationType? = nil
    
    var filteredNotifications: [NotificationItem] {
        if let filter = selectedFilter {
            return notifications.filter { $0.type == filter }
        }
        return notifications
    }
    
    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }
    
    var body: some View {
        // NavigationStack removed to avoid nesting
            ZStack {
                Color.backgroundDark.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    if !notifications.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                FilterButton(title: "All", isSelected: selectedFilter == nil) {
                                    withAnimation {
                                        selectedFilter = nil
                                    }
                                }
                                
                                ForEach(NotificationType.allCases, id: \.self) { type in
                                    FilterButton(title: type.rawValue, isSelected: selectedFilter == type) {
                                        withAnimation {
                                            selectedFilter = type
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                    
                    if filteredNotifications.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "bell.slash.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.textSecondary)
                            
                            Text("No Notifications")
                                .font(.title2)
                                .foregroundColor(.textPrimary)
                            
                            Text("You're all caught up!")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(filteredNotifications) { notification in
                                    NavigationLink(value: AppRoute.notificationDetail(notification)) {
                                        NotificationRowView(notification: notification)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if unreadCount > 0 {
                        Text("\(unreadCount)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }

struct NotificationRowView: View {
    let notification: NotificationItem
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconForType(notification.type))
                .font(.title2)
                .foregroundColor(colorForType(notification.type))
                .frame(width: 50, height: 50)
                .background(colorForType(notification.type).opacity(0.2))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(notification.title)
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                    
                    if !notification.isRead {
                        Circle()
                            .fill(Color.primaryBlue)
                            .frame(width: 8, height: 8)
                    }
                }
                
                Text(notification.message)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
                    .lineLimit(2)
                
                Text(notification.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.textSecondary)
                .font(.caption)
        }
        .padding()
        .background(notification.isRead ? Color.cardDark : Color.primaryBlue.opacity(0.1))
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
    NotificationsView()
}

