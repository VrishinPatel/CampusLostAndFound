import Foundation
import FirebaseFirestoreSwift

struct LostFoundItem: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var itemDescription: String
    var date: Date
    var isLost: Bool
    var userId: String
    var imageURL: String? // New property
}
