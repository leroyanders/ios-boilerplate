import PhotosUI

protocol AvatarRemoteStoreProtocol {
	func uploadAvatar(userId: String, image: UIImage) async throws -> String
}
