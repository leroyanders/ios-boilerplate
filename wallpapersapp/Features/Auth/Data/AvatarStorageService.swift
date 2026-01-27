import FirebaseStorage
import UIKit

final class AvatarRemoteStore {
    private let storage = Storage.storage().reference()

	func uploadAvatar(userId: String, image: UIImage) async throws -> String {
		guard let data = image.jpegData(compressionQuality: 0.8) else {
			throw NSError(domain: "ImageEncoding", code: -1)
		}

		let ref = Storage.storage().reference().child("avatars/\(userId).jpg")

		_ = try await ref.putDataAsync(data)

		let url = try await ref.downloadURL()

		return url.absoluteString
	}
}
