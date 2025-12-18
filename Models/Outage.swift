import Foundation

enum OutageSeverity: String, CaseIterable, Hashable {
    case minor = "Minor"
    case moderate = "Moderate"
    case major = "Major"
    case critical = "Critical"
    
    var color: String {
        switch self {
        case .minor: return "blue"
        case .moderate: return "yellow"
        case .major: return "orange"
        case .critical: return "red"
        }
    }
}

struct Outage: Identifiable, Hashable {
    let id: UUID
    var area: String
    var severity: OutageSeverity
    var description: String
    var startTime: Date
    var estimatedEndTime: Date?
    var isResolved: Bool
    var affectedCustomers: Int
    var cause: String
    
    init(id: UUID = UUID(), area: String, severity: OutageSeverity, description: String, startTime: Date = Date(), estimatedEndTime: Date? = nil, isResolved: Bool = false, affectedCustomers: Int, cause: String) {
        self.id = id
        self.area = area
        self.severity = severity
        self.description = description
        self.startTime = startTime
        self.estimatedEndTime = estimatedEndTime
        self.isResolved = isResolved
        self.affectedCustomers = affectedCustomers
        self.cause = cause
    }
}

