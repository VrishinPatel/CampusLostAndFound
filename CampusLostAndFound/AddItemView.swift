import SwiftUI
import SwiftUI
import PhotosUI
import FirebaseStorage


struct AddItemView: View {
    @ObservedObject var viewModel: LostFoundViewModel
    @ObservedObject var authViewModel: AuthenticationViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var isLost = true
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Item Title", text: $title)
                TextField("Description", text: $description)
                Picker("Status", selection: $isLost) {
                    Text("Lost").tag(true)
                    Text("Found").tag(false)
                }
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Text(selectedImage == nil ? "Select Image" : "Change Image")
                }
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                Button("Add Item") {
                    addItem()
                }
                .disabled(title.isEmpty || description.isEmpty)
            }
            .navigationTitle("Add New Item")
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }

    func addItem() {
        guard let userId = authViewModel.user?.uid else { return }

        if let image = selectedImage {
            viewModel.uploadImage(image: image) { imageURL in
                viewModel.addItem(
                    title: title,
                    description: description,
                    isLost: isLost,
                    userId: userId,
                    imageURL: imageURL
                )
                resetForm()
            }
        } else {
            viewModel.addItem(
                title: title,
                description: description,
                isLost: isLost,
                userId: userId,
                imageURL: nil
            )
            resetForm()
        }
    }

    func resetForm() {
        title = ""
        description = ""
        isLost = true
        selectedImage = nil
    }
}
