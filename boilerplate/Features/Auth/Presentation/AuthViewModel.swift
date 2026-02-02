import Foundation
import SwiftUI
import Observation
import FirebaseAuth

@MainActor
@Observable
final class AuthViewModel {
	private let useCase: AuthUseCase

	var user: AppUser?
	var errorMessage: String?
	var errorCode: AuthErrorCode?
	var authFlow: AuthFlowEnum = .signIn
	var isLoading: Bool = false

	init(useCase: AuthUseCase) {
		self.useCase = useCase
	}

	func tryAutoLogin() async {
		await perform {
			self.user = try await useCase.tryAutoLogin()
		}
	}

	func login(email: String, password: String) async {
		await perform {
			self.user = try await useCase.login(email: email, password: password)
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
			self.user = try await useCase.register(
				email: email,
				password: password,
				name: name,
				lastName: lastName,
				avatar: avatar
			)
		} onError: { error in
			self.handleLoginError(error)
		}
	}

	func logout() {
		try? useCase.logout()
		user = nil
	}

	// MARK: - Helpers

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
		let nsError = error as NSError

		guard let code = AuthErrorCode(rawValue: nsError.code) else {
			errorMessage = "Authentication failed."
			return
		}

		errorCode = code

		switch code {
		case .userNotFound, .invalidCredential:
			authFlow = .signUp
		default:
			errorMessage = mapAuthError(error)
		}
	}

	private func mapAuthError(_ error: Error) -> String {
		let nsError = error as NSError

		guard let code = AuthErrorCode(rawValue: nsError.code) else {
			return "Authentication failed."
		}

		errorCode = code

		switch code {
		case .wrongPassword:
			return "Incorrect password"
		case .userNotFound:
			return "Account not found"
		case .invalidEmail:
			return "Invalid email"
		case .networkError:
			return "Network error"
		case .emailAlreadyInUse:
			return "Email already registered"
		case .weakPassword:
			return "Password too weak"
		case .invalidCredential:
			return "Invalid credentials"
		default:
			return "Auth error: \(code.rawValue)"
		}
	}
}
