protocol AuthNetworkService {
    func login(email: String, password: String) async throws -> AppUser
    func register(email: String, password: String) async throws -> AppUser
}
