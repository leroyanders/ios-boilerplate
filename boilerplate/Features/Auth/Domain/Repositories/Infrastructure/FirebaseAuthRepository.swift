import PhotosUI

final class FirebaseAuthRepository: AuthRepository {

    private let authRemote: AuthRemoteServiceProtocol
    private let userRemote: UserRemoteStoreProtocol
    private let userLocal: UserLocalStoreProtocol
    private let avatarRemote: AvatarRemoteStoreProtocol

    init(
        authRemote: AuthRemoteServiceProtocol,
        userRemote: UserRemoteStoreProtocol,
        userLocal: UserLocalStoreProtocol,
        avatarRemote: AvatarRemoteStoreProtocol
    ) {
        self.authRemote = authRemote
        self.userRemote = userRemote
        self.userLocal = userLocal
        self.avatarRemote = avatarRemote
    }

    func restoreSession() async throws -> AppUser {
        let sessionUser = try await authRemote.restoreSession()
        return try await userRemote.fetchUser(id: sessionUser.id)
    }

    func login(email: String, password: String) async throws -> AppUser {
        let sessionUser = try await authRemote.login(email: email, password: password)
        let fullUser = try await userRemote.fetchUser(id: sessionUser.id)
        try userLocal.save(user: fullUser)
        return fullUser
    }

    func register(
        email: String,
        password: String,
        name: String,
        lastName: String,
        avatar: UIImage?
    ) async throws -> AppUser {

        var user = try await authRemote.register(
            email: email,
            password: password,
            name: name,
            lastName: lastName
        )

        if let avatar {
            let url = try await avatarRemote.uploadAvatar(
                userId: user.id,
                image: avatar
            )
            user.image = url
        }

        try await userRemote.save(user: user)
        try userLocal.save(user: user)

        return user
    }

    func logout() throws {
        try authRemote.logout()
        try userLocal.deleteUser()
    }
}
