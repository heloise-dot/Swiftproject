import Foundation
import CoreLocation
import SwiftUI

// MARK: - Water Flow Status Enum
enum WaterFlowStatus: String, CaseIterable, Hashable {
    case normal = "Normal"
    case low = "Low"
    case high = "High"
    case critical = "Critical"
    case maintenance = "Maintenance"
    
    var color: Color {
        switch self {
        case .normal: return Color.primaryBlue
        case .low: return Color.warning
        case .high: return Color.primaryTeal
        case .critical: return Color.error
        case .maintenance: return Color.statusMaintenance
        }
    }
    
    var description: String {
        switch self {
        case .normal: return "Flowing within normal range"
        case .low: return "Water levels are lower than average"
        case .high: return "Water levels are elevated"
        case .critical: return "Urgent attention needed"
        case .maintenance: return "Scheduled maintenance in progress"
        }
    }
}

// MARK: - Water Source Type Enum
enum WaterSourceType: String, CaseIterable, Hashable {
    case river = "River"
    case lake = "Lake"
    case reservoir = "Reservoir"
    case canal = "Canal"
    case distributionPoint = "Distribution Point"
    case pumpStation = "Pump Station"
    case treatmentPlant = "Treatment Plant"
    case well = "Well"
    
    var icon: String {
        switch self {
        case .river: return "water.waves"
        case .lake: return "drop.fill"
        case .reservoir: return "cylinder.fill"
        case .canal: return "arrow.triangle.2.circlepath"
        case .distributionPoint: return "location.fill"
        case .pumpStation: return "bolt.fill"
        case .treatmentPlant: return "building.2.fill"
        case .well: return "circle.dotted"
        }
    }
}

// MARK: - Water Source Model (Unified)
struct MapWaterSource: Identifiable, Hashable {
    let id: UUID
    var name: String
    var type: WaterSourceType
    var flowRate: Double // in m3/s
    var quality: String // Good, Fair, Poor
    var status: WaterFlowStatus
    var path: [CLLocationCoordinate2D] // Points defining the water source path
    var area: String? // Optional: area this source serves
    var pressure: Double? // Optional: pressure in PSI
    var lastUpdated: Date
    var alerts: [String] // Optional alerts/warnings
    
    init(
        id: UUID = UUID(),
        name: String,
        type: WaterSourceType,
        flowRate: Double,
        quality: String = "Good",
        status: WaterFlowStatus = .normal,
        path: [CLLocationCoordinate2D],
        area: String? = nil,
        pressure: Double? = nil,
        lastUpdated: Date = Date(),
        alerts: [String] = []
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.flowRate = flowRate
        self.quality = quality
        self.status = status
        self.path = path
        self.area = area
        self.pressure = pressure
        self.lastUpdated = lastUpdated
        self.alerts = alerts
    }
    
    // Calculated property for display
    var flowRateDisplay: String {
        return String(format: "%.1f m³/s", flowRate)
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MapWaterSource, rhs: MapWaterSource) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Sample Data for Rwanda
struct WaterMapData {
    static let rwandaCenter = CLLocationCoordinate2D(latitude: -1.9403, longitude: 29.8739)
    static let rwandaSpan = 1.0 // Degrees
    
    static var waterSources: [MapWaterSource] = [
        // Major Rivers
        MapWaterSource(
            name: "Nyabarongo River",
            type: .river,
            flowRate: 180.5,
            quality: "Good",
            status: .normal,
            path: [
                CLLocationCoordinate2D(latitude: -1.70, longitude: 29.60),
                CLLocationCoordinate2D(latitude: -1.80, longitude: 29.75),
                CLLocationCoordinate2D(latitude: -1.94, longitude: 29.90),
                CLLocationCoordinate2D(latitude: -2.05, longitude: 30.05),
                CLLocationCoordinate2D(latitude: -2.15, longitude: 30.20)
            ],
            area: "Kigali Central"
        ),
        MapWaterSource(
            name: "Akagera River",
            type: .river,
            flowRate: 250.2,
            quality: "Good",
            status: .high,
            path: [
                CLLocationCoordinate2D(latitude: -2.30, longitude: 30.50),
                CLLocationCoordinate2D(latitude: -2.10, longitude: 30.60),
                CLLocationCoordinate2D(latitude: -1.80, longitude: 30.45),
                CLLocationCoordinate2D(latitude: -1.50, longitude: 30.35)
            ],
            area: "Eastern Province"
        ),
        MapWaterSource(
            name: "Mukungwa River",
            type: .river,
            flowRate: 85.0,
            quality: "Fair",
            status: .low,
            path: [
                CLLocationCoordinate2D(latitude: -1.50, longitude: 29.60),
                CLLocationCoordinate2D(latitude: -1.55, longitude: 29.65),
                CLLocationCoordinate2D(latitude: -1.65, longitude: 29.70)
            ],
            area: "Northern Province"
        ),
        
        // Lakes
        MapWaterSource(
            name: "Lake Kivu",
            type: .lake,
            flowRate: 0.0,
            quality: "Excellent",
            status: .normal,
            path: [
                CLLocationCoordinate2D(latitude: -2.00, longitude: 29.00),
                CLLocationCoordinate2D(latitude: -2.10, longitude: 29.10),
                CLLocationCoordinate2D(latitude: -2.15, longitude: 29.20),
                CLLocationCoordinate2D(latitude: -2.05, longitude: 29.15),
                CLLocationCoordinate2D(latitude: -1.95, longitude: 29.05)
            ],
            area: "Western Province"
        ),
        
        // Reservoirs
        MapWaterSource(
            name: "Kigali Main Reservoir",
            type: .reservoir,
            flowRate: 45.8,
            quality: "Good",
            status: .normal,
            path: [
                CLLocationCoordinate2D(latitude: -1.95, longitude: 30.05),
                CLLocationCoordinate2D(latitude: -1.96, longitude: 30.06),
                CLLocationCoordinate2D(latitude: -1.97, longitude: 30.05),
                CLLocationCoordinate2D(latitude: -1.96, longitude: 30.04)
            ],
            area: "Kigali Central",
            pressure: 65.0
        ),
        
        // Distribution Points
        MapWaterSource(
            name: "Gasabo Distribution Point",
            type: .distributionPoint,
            flowRate: 12.5,
            quality: "Good",
            status: .low,
            path: [
                CLLocationCoordinate2D(latitude: -1.90, longitude: 30.10)
            ],
            area: "Gasabo",
            pressure: 45.0
        ),
        MapWaterSource(
            name: "Nyarugenge Distribution Point",
            type: .distributionPoint,
            flowRate: 15.2,
            quality: "Good",
            status: .normal,
            path: [
                CLLocationCoordinate2D(latitude: -1.94, longitude: 30.05)
            ],
            area: "Nyarugenge",
            pressure: 58.0
        ),
        
        // Canals
        MapWaterSource(
            name: "Kigali Canal System",
            type: .canal,
            flowRate: 32.0,
            quality: "Fair",
            status: .normal,
            path: [
                CLLocationCoordinate2D(latitude: -1.92, longitude: 30.08),
                CLLocationCoordinate2D(latitude: -1.93, longitude: 30.12),
                CLLocationCoordinate2D(latitude: -1.94, longitude: 30.15)
            ],
            area: "Kigali Central"
        ),
        
        // Pump Stations
        MapWaterSource(
            name: "Pump Station A",
            type: .pumpStation,
            flowRate: 28.5,
            quality: "Good",
            status: .normal,
            path: [
                CLLocationCoordinate2D(latitude: -1.88, longitude: 30.07)
            ],
            area: "Gasabo",
            pressure: 70.0
        ),
        
        // Treatment Plants
        MapWaterSource(
            name: "Kigali Treatment Plant",
            type: .treatmentPlant,
            flowRate: 95.0,
            quality: "Excellent",
            status: .normal,
            path: [
                CLLocationCoordinate2D(latitude: -1.96, longitude: 30.03)
            ],
            area: "Kigali Central",
            pressure: 80.0
        )
    ]
}
