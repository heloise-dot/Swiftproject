import Foundation

struct WaterTip: Identifiable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var category: String
    var impact: String
    var icon: String
    
    init(id: UUID = UUID(), title: String, description: String, category: String, impact: String, icon: String = "drop.fill") {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.impact = impact
        self.icon = icon
    }
}
