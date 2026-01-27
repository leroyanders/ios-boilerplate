import SwiftUI
import PhotosUI

struct AvatarPicker: View {
    @Binding var avatarImage: UIImage?

    @State private var selectedItem: PhotosPickerItem?
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if let avatarImage {
                        Image(uiImage: avatarImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray.opacity(0.4))
                            .padding(18)
                            .background(Color.gray.opacity(0.08))
                    }
                }
                .frame(width: 110, height: 110)
                .clipShape(Circle())

                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 34, height: 34)
                        .background(.black.opacity(0.9))
                        .clipShape(Circle())
                }
                .disabled(isLoading)
            }

            if avatarImage != nil {
                Button(role: .destructive) {
                    avatarImage = nil
                    selectedItem = nil
                } label: {
                    Text("Remove photo")
                        .font(.footnote)
                }
            }

            if isLoading {
                ProgressView()
                    .scaleEffect(0.9)
            }
        }
        .task(id: selectedItem) {
            await loadSelectedImage()
        }
    }

    private func loadSelectedImage() async {
        guard let selectedItem else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            if let data = try await selectedItem.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                avatarImage = uiImage
            }
        } catch {
            avatarImage = nil
        }
    }
}
