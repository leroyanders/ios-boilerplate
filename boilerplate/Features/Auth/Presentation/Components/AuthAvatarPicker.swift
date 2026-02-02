import SwiftUI
import PhotosUI

struct AuthAvatarPicker: View {
	@Binding var avatarImage: UIImage?
	@State private var selectedItem: PhotosPickerItem?
	@State private var isLoading = false
	@Environment(\.colorScheme) private var scheme
	
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
							.foregroundStyle(Color.appTertiary(scheme))
							.padding(18)
							.background(Color.appQuinary(scheme))
					}
					
					PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
						Image(systemName: avatarImage != nil ? "xmark.circle.fill" : "camera.fill")
							.font(.system(size: 14, weight: .semibold))
							.foregroundStyle(Color.appQuinary(scheme))
							.frame(width: 34, height: 34)
							.background(Color.appPrimary(scheme))
							.clipShape(Circle())
					}
					.disabled(isLoading)
				}
				.frame(width: 100, height: 100)
				.clipShape(Circle())
			}
			
			if avatarImage != nil {
				Button(role: .destructive) {
					avatarImage = nil
					selectedItem = nil
				} label: {
					Text("Remove photo")
						.font(.footnote)
						.foregroundStyle(Color.appSecondary(scheme))
				}
			}
			
			if isLoading {
				ProgressView()
					.scaleEffect(0.9)
			}
		}
		.frame(width: 100, height: 100)
		.task(id: selectedItem) {
			await loadSelectedImage()
		}
	}
	
	private func loadSelectedImage() async {
		guard let selectedItem else { return }
		defer { isLoading = false }
		
		isLoading = true
		
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
