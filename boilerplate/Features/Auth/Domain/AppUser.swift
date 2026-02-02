struct AppUser: Identifiable, AppUserProtocol {
	var id: String
	var email: String
	var token: String
	var name: String
	var lastName: String
	var image: String

	init(
		id: String,
		email: String,
		token: String = "",
		name: String = "",
		lastName: String = "",
		image: String = ""
	) {
		self.id = id
		self.email = email
		self.token = token
		self.name = name
		self.lastName = lastName
		self.image = image
	}
}

extension AppUser {
	init(from persistable: AppUserProtocol) {
		self.id = persistable.id
		self.email = persistable.email
		self.token = persistable.token
		self.name = persistable.name
		self.lastName = persistable.lastName
		self.image = persistable.image
	}
}
