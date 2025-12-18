import Foundation

enum WaterStatus: String, CaseIterable, Hashable {
    case available = "WATER ON"
    case lowPressure = "LOW PRESSURE"
    case scheduledMaintenance = "SCHEDULED MAINTENANCE"
    case outage = "WATER OFF"
    
    var color: String {
        switch self {
        case .available: return "green"
        case .lowPressure: return "yellow"
        case .scheduledMaintenance: return "orange"
        case .outage: return "red"
        }
    }
}

struct Area: Identifiable, Hashable {
    let id: UUID
    var name: String
    var status: WaterStatus
    var population: Int
    var lastUpdated: Date
    var waterSource: String
    
    init(id: UUID = UUID(), name: String, status: WaterStatus, population: Int, lastUpdated: Date = Date(), waterSource: String) {
        self.id = id
        self.name = name
        self.status = status
        self.population = population
        self.lastUpdated = lastUpdated
        self.waterSource = waterSource
    }
}

