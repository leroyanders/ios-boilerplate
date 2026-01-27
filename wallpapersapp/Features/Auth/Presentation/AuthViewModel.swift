import Foundation
import SwiftUI
import Observation
import FirebaseAuth

@MainActor
@Observable
final class AuthViewModel {
	
		// MARK: - State
	var user: AppUser?
	var errorMessage: String?
	var authFlow: AuthFlowEnum = .signIn
	var isLoading: Bool = false
	
		// MARK: - Data layer
	private let authRemote: AuthRemoteService = AuthRemoteService()
	private let userRemote: UserRemoteStore = UserRemoteStore()
	private let userLocal: UserLocalStore = UserLocalStore()
	private let avatarRemote: AvatarRemoteStore = AvatarRemoteStore()

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
		} onError: { error in
			self.handleLoginError(error)
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
		defer { isLoading = false }
		
		isLoading = true
		errorMessage = nil
		
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
		if let authError = error as? AuthErrorCode {
			switch authError.code {
			case .invalidCredential:
				authFlow = .signUp
				return
			default:
				break
			}
		}
		
		errorMessage = mapAuthError(error)
	}
	
	private func mapAuthError(_ error: Error) -> String {
		if let authError = error as? AuthErrorCode {
			switch authError.code {
			case .wrongPassword: return "Incorrect password"
			case .userNotFound: return "Account not found"
			case .invalidEmail: return "Invalid email format"
			case .networkError: return "Network connection failed"
			case .emailAlreadyInUse: return "Email already registered"
			case .weakPassword: return "Password too weak (min 6 characters)"
			case .invalidCredential: return "Invalid credentials"
			default: return "Authentication error. Code: \(authError.code.rawValue)"
			}
		}
		
		return "Authentication failed. Please try again."
	}
}
