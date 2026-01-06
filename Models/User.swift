import Foundation

enum UserRole: String, CaseIterable {
    case customer
    case admin
}

struct User: Identifiable, Hashable {
    let id: UUID
    var name: String
    var email: String
    var phone: String
    var address: String
    var role: UserRole
    var area: String
    
    init(id: UUID = UUID(), name: String, email: String, phone: String, address: String, role: UserRole, area: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
        self.role = role
        self.area = area
    }
}

