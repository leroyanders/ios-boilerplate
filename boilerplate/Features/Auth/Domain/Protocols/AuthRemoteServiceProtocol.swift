protocol AuthRemoteServiceProtocol {
	func register(email: String, password: String, name: String?, lastName: String?) async throws -> AppUser
	func login(email: String, password: String) async throws -> AppUser
	func restoreSession() async throws -> AppUser
	func logout() throws
}
