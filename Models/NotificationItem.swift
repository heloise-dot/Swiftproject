import Foundation

enum NotificationType: String, CaseIterable, Hashable {
    case outage = "Outage Alert"
    case maintenance = "Maintenance"
    case update = "Status Update"
    case tip = "Water Tip"
    case emergency = "Emergency"
}

struct NotificationItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var message: String
    var type: NotificationType
    var timestamp: Date
    var isRead: Bool
    var area: String?
    var actionUrl: String?
    
    init(id: UUID = UUID(), title: String, message: String, type: NotificationType, timestamp: Date = Date(), isRead: Bool = false, area: String? = nil, actionUrl: String? = nil) {
        self.id = id
        self.title = title
        self.message = message
        self.type = type
        self.timestamp = timestamp
        self.isRead = isRead
        self.area = area
        self.actionUrl = actionUrl
    }
}

