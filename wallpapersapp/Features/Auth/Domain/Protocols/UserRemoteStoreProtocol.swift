protocol UserRemoteStoreProtocol {
	func save(user: AppUser) async throws
	func fetchUser(id: String) async throws -> AppUser
}
