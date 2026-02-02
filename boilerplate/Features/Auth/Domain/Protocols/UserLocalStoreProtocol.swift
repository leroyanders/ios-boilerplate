protocol UserLocalStoreProtocol {
	func save(user: AppUser) throws
	func loadUser() throws -> AppUser?
	func deleteUser() throws
	func loadToken() -> String?
	func clearToken()
}
