import Foundation

enum SourceType: String, CaseIterable, Hashable {
    case reservoir = "Reservoir"
    case well = "Well"
    case pump = "Pump Station"
    case treatment = "Treatment Plant"
}

struct WaterSource: Identifiable, Hashable {
    let id: UUID
    var name: String
    var type: SourceType
    var capacity: Double
    var currentLevel: Double
    var isActive: Bool
    var location: String
    var lastMaintenance: Date
    
    init(id: UUID = UUID(), name: String, type: SourceType, capacity: Double, currentLevel: Double, isActive: Bool, location: String, lastMaintenance: Date = Date()) {
        self.id = id
        self.name = name
        self.type = type
        self.capacity = capacity
        self.currentLevel = currentLevel
        self.isActive = isActive
        self.location = location
        self.lastMaintenance = lastMaintenance
    }
    
    var levelPercentage: Double {
        (currentLevel / capacity) * 100
    }
}

