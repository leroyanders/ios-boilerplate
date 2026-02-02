import PhotosUI

final class AuthUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func tryAutoLogin() async throws -> AppUser {
        try await repository.restoreSession()
    }

    func login(email: String, password: String) async throws -> AppUser {
        try await repository.login(email: email, password: password)
    }

    func register(
        email: String,
        password: String,
        name: String,
        lastName: String,
        avatar: UIImage?
    ) async throws -> AppUser {
        try await repository.register(
            email: email,
            password: password,
            name: name,
            lastName: lastName,
            avatar: avatar
        )
    }

    func logout() throws {
        try repository.logout()
    }
}
