import CoreData

final class UserLocalStore: UserPersistenceService {
	private let context: NSManagedObjectContext

	init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
		self.context = context
	}

	func clearTokenFromCoreData() {
		let request = CDUser.fetchRequest()
		if let user = try? PersistenceController.shared.container.viewContext.fetch(request).first {
			PersistenceController.shared.container.viewContext.delete(user)
			try? PersistenceController.shared.container.viewContext.save()
		}
	}

	func loadTokenFromCoreData() -> String? {
		let request = CDUser.fetchRequest()
		request.fetchLimit = 1
		return try? PersistenceController.shared.container.viewContext
			.fetch(request)
			.first?
			.token
	}

	func save(user: AppUser) throws {
		try deleteUser()

		let cdUser = CDUser(context: context)
		cdUser.id = user.id
		cdUser.email = user.email
		cdUser.token = user.token
		cdUser.name = user.name
		cdUser.lastName = user.lastName
		cdUser.image = user.image

		try context.save()
	}

	func loadUser() throws -> AppUser? {
		let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
		request.fetchLimit = 1

		let result = try context.fetch(request)
		guard let cdUser = result.first else { return nil }

		return AppUser(
			id: cdUser.id ?? "",
			email: cdUser.email ?? "",
			token: cdUser.token ?? "",
			name: cdUser.name ?? "",
			lastName: cdUser.lastName ?? "",
			image: cdUser.image ?? ""
		)
	}

	func deleteUser() throws {
		let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
		let users = try context.fetch(request)

		for user in users {
			context.delete(user)
		}

		if context.hasChanges {
			try context.save()
		}
	}
}
