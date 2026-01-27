struct AppUser: Identifiable {
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

protocol UserPersistable {
	var id: String { get }
	var email: String { get }
	var token: String { get }
	var name: String { get }
	var lastName: String { get }
	var image: String { get }
}

extension AppUser {
	init(from persistable: UserPersistable) {
		self.id = persistable.id
		self.email = persistable.email
		self.token = persistable.token
		self.name = persistable.name
		self.lastName = persistable.lastName
		self.image = persistable.image
	}
}
