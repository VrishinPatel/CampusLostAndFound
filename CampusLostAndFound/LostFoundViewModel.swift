import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage


class LostFoundViewModel: ObservableObject {
    @Published var items: [LostFoundItem] = []

    func addItem(item: LostFoundItem) {
        items.append(item)
    }
    
    class LostFoundViewModel: ObservableObject {
        @Published var items: [LostFoundItem] = []
        private let db = Firestore.firestore()
        private let storage = Storage.storage()

        // Existing methods...

        func uploadImage(image: UIImage, completion: @escaping (_ url: String?) -> Void) {
            let storageRef = storage.reference()
            let imageName = UUID().uuidString + ".jpg"
            let imageRef = storageRef.child("images/\(imageName)")

            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                print("Failed to get JPEG data from image.")
                completion(nil)
                return
            }

            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            imageRef.putData(imageData, metadata: metadata) { _, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                imageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                        completion(nil)
                        return
                    }
                    completion(url?.absoluteString)
                }
            }
        }

        func addItem(title: String, description: String, isLost: Bool, userId: String, imageURL: String?) {
            let newItem = LostFoundItem(
                title: title,
                itemDescription: description,
                date: Date(),
                isLost: isLost,
                userId: userId,
                imageURL: imageURL
            )
            do {
                _ = try db.collection("items").addDocument(from: newItem)
            } catch {
                print("Error adding item: \(error.localizedDescription)")
            }
        }

        // Existing methods...
    }

}
