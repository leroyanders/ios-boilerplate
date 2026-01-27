struct RegisterUseCase {
    let authService: AuthNetworkService
    let persistence: UserPersistenceService

    func execute(email: String, password: String) async throws -> AppUser {
		let user = try await authService.register(
			email: email,
			password: password
		)
        
		try persistence.save(user: user)
        return user
    }
}
