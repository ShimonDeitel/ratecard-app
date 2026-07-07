import Foundation

struct Item: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var field1: String   // Service
    var field2: String   // Price
    var status: String
    var notes: String = ""
    var createdAt: Date = Date()
}

enum Status {
    static let all = ["Standard", "Rush", "Package"]
}
