import FirebaseAuth

final class AuthRemoteService {
	func register(email: String, password: String, name: String? = nil, lastName: String? = nil) async throws -> AppUser {
		let result = try await Auth.auth()
			.createUser(withEmail: email, password: password)

		let firebaseUser = result.user

		return AppUser(
			id: firebaseUser.uid,
			email: firebaseUser.email ?? "",
			name: name ?? "",
			lastName: lastName ?? ""
		)
	}

	func login(email: String, password: String) async throws -> AppUser {
		let result = try await Auth.auth()
			.signIn(withEmail: email, password: password)

		let firebaseUser = result.user

		return AppUser(
			id: firebaseUser.uid,
			email: firebaseUser.email ?? ""
		)
	}

	func restoreSession() async throws -> AppUser {
		guard let firebaseUser = Auth.auth().currentUser else {
			throw NSError(domain: "NoSession", code: 401)
		}

		return AppUser(
			id: firebaseUser.uid,
			email: firebaseUser.email ?? ""
		)
	}

	func logout() throws {
		try Auth.auth().signOut()
	}
}
