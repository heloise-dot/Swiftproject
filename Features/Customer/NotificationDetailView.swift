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
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .foregroundColor(colorForType(notification.type))
                            .padding(20)
                            .background(colorForType(notification.type).opacity(0.1))
                            .clipShape(Circle())
                        
                        VStack(spacing: 8) {
                            Text(notification.title)
                                .font(.heading1)
                                .foregroundColor(.textPrimary)
                                .multilineTextAlignment(.center)
                            
                            HStack(spacing: 8) {
                                StatusBadge(text: notification.type.rawValue, color: colorForType(notification.type))
                                StatusBadge(text: notification.priority.rawValue, color: notification.priority.color)
                            }
                        }
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Message")
                        
                        Text(notification.message)
                            .font(.bodyLarge)
                            .foregroundColor(.textPrimary)
                            .lineSpacing(6)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.cardDark)
                            .cornerRadius(16)
                    }
                    
                    VStack(spacing: 16) {
                        if let area = notification.area {
                            InfoCard(
                                icon: "location.fill",
                                title: "Affected Area",
                                value: area,
                                color: .blue
                            )
                        }
                        
                        InfoCard(
                            icon: "clock.fill",
                            title: "Time Received",
                            value: notification.timestamp.formatted(date: .abbreviated, time: .shortened),
                            color: .purple
                        )
                    }
                    
                    // MARK: Interactive Actions
                    VStack(spacing: 16) {
                        SectionHeader(title: "Actions")
                        
                        HStack(spacing: 12) {
                            ActionButton(title: "Remind Me", icon: "bell.badge", color: .primaryBlue) {
                                // Logic for reminder
                            }
                            
                            ActionButton(title: "Report Issue", icon: "exclamationmark.bubble", color: .orange) {
                                // Logic for reporting
                            }
                        }
                        
                        if notification.type == .outage {
                            NavigationLink(destination: OutageListView()) {
                                HStack {
                                    Image(systemName: "map.fill")
                                        .foregroundColor(.primaryBlue)
                                    Text("View Outage Map")
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
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if !isRead {
                withAnimation {
                    isRead = true
                }
            }
        }
    }
    
    // Supporting View for Actions
    struct ActionButton: View {
        let title: String
        let icon: String
        let color: Color
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                VStack(spacing: 8) {
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundColor(color)
                    Text(title)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.cardDark)
                .cornerRadius(12)
            }
            .buttonStyle(.interactive)
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

