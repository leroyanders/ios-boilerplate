import PhotosUI

protocol AuthRepository {
    func login(email: String, password: String) async throws -> AppUser
    func register(
        email: String,
        password: String,
        name: String,
        lastName: String,
        avatar: UIImage?
    ) async throws -> AppUser

    func restoreSession() async throws -> AppUser
    func logout() throws
}
