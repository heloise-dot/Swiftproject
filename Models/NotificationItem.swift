import Foundation
import SwiftUI

enum NotificationType: String, CaseIterable, Hashable {
    case outage = "Outage Alert"
    case maintenance = "Maintenance"
    case update = "Status Update"
    case tip = "Water Tip"
    case emergency = "Emergency"
}

enum NotificationPriority: String, CaseIterable, Hashable {
    case low = "Low"
    case normal = "Normal"
    case high = "High"
    case critical = "Critical"
    
    var color: Color {
        switch self {
        case .low: return .blue
        case .normal: return .green
        case .high: return .orange
        case .critical: return .red
        }
    }
}

struct NotificationItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var message: String
    var type: NotificationType
    var priority: NotificationPriority
    var timestamp: Date
    var isRead: Bool
    var area: String?
    var actionUrl: String?
    
    init(id: UUID = UUID(), title: String, message: String, type: NotificationType, priority: NotificationPriority = .normal, timestamp: Date = Date(), isRead: Bool = false, area: String? = nil, actionUrl: String? = nil) {
        self.id = id
        self.title = title
        self.message = message
        self.type = type
        self.priority = priority
        self.timestamp = timestamp
        self.isRead = isRead
        self.area = area
        self.actionUrl = actionUrl
    }
}

