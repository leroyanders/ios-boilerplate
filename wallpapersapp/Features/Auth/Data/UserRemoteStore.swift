import FirebaseFirestore

final class UserRemoteStore: UserRemoteStoreProtocol {
    private let db = Firestore.firestore()

	func save(user: AppUser) async throws {
        try await db
            .collection("users")
            .document(user.id)
            .setData([
                "email": user.email,
				"name": user.name,
				"lastName": user.lastName,
				"image": user.image,
                "createdAt": Timestamp()
            ])
    }

    func fetchUser(id: String) async throws -> AppUser {
        let doc = try await db
            .collection("users")
            .document(id)
            .getDocument()

        let data = doc.data() ?? [:]

        return AppUser(
            id: doc.documentID,
            email: data["email"] as? String ?? "",
			name: data["name"] as? String ?? "",
			lastName: data["lastName"] as? String ?? "",
			image: data["image"] as? String ?? ""
        )
    }
}
