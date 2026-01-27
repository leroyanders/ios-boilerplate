import Foundation
import SwiftUI
import Observation
import FirebaseAuth

@Observable
final class AuthViewModel {
	
	// MARK: - State
	var user: AppUser?
	var errorMessage: String?
	var authFlow: AuthFlowEnum = .signIn
	var isLoading: Bool = false
	
	// MARK: - Data layer
	private let authRemote: AuthRemoteService
	private let userRemote: UserRemoteStore
	private let userLocal: UserLocalStore
	private let avatarRemote: AvatarRemoteStore
	
	// MARK: - Init
	init(
		authRemote: AuthRemoteService = AuthRemoteService(),
		userRemote: UserRemoteStore = UserRemoteStore(),
		userLocal: UserLocalStore = UserLocalStore(),
		avatarRemote: AvatarRemoteStore = AvatarRemoteStore()
	) {
		self.authRemote = authRemote
		self.userRemote = userRemote
		self.userLocal = userLocal
		self.avatarRemote = avatarRemote
	}
	
	// MARK: - Public API
	func tryAutoLogin() async {
		guard let sessionUser = try? await authRemote.restoreSession() else {
			user = nil
			return
		}
		
		await loadFullProfile(for: sessionUser.id)
	}
	
	func login(email: String, password: String) async {
		await perform {
			let sessionUser = try await authRemote.login(email: email, password: password)
			await loadFullProfile(for: sessionUser.id)
		} onError: { error in
			self.handleLoginError(error)
		}
	}
	
	func register(
		email: String,
		password: String,
		name: String,
		lastName: String,
		avatar: UIImage?
	) async {
		await perform {
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
			
			self.user = user
		}
	}
	
	func logout() {
		try? authRemote.logout()
		user = nil
	}
	
	// MARK: - Private helpers
	private func loadFullProfile(for userId: String) async {
		let fullUser = try? await userRemote.fetchUser(id: userId)
		if let fullUser {
			self.user = fullUser
			try? userLocal.save(user: fullUser)
		}
	}
	
	private func perform(
		_ action: () async throws -> Void,
		onError: ((Error) -> Void)? = nil
	) async {
		isLoading = true
		errorMessage = nil
		defer { isLoading = false }
		
		do {
			try await action()
		} catch {
			if let onError {
				onError(error)
			} else {
				errorMessage = mapAuthError(error)
			}
		}
	}
	
	private func handleLoginError(_ error: Error) {
		let nsError = error as NSError
		
		if nsError.domain == AuthErrorDomain,
		   nsError.code == AuthErrorCode.invalidCredential.rawValue {
			authFlow = .signUp
			return
		}
		
		errorMessage = mapAuthError(error)
	}
	
	private func mapAuthError(_ error: Error) -> String {
		let nsError = error as NSError
		
		guard nsError.domain == AuthErrorDomain else {
			return "Unexpected error"
		}
		
		switch nsError.code {
		case AuthErrorCode.wrongPassword.rawValue:
			return "Wrong password"
		case AuthErrorCode.userNotFound.rawValue:
			return "User not found"
		case AuthErrorCode.invalidEmail.rawValue:
			return "Invalid email address"
		case AuthErrorCode.networkError.rawValue:
			return "Network error. Try again."
		default:
			return "Authentication failed"
		}
	}
}
