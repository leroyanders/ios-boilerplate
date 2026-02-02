import SwiftUI
import CoreData
import FirebaseCore

@main
struct YourApp: App {
	let persistenceController = PersistenceController.shared
	let authViewModel: AuthViewModel

	init() {
		FirebaseApp.configure()

		// Infra
		let repository = FirebaseAuthRepository(
			authRemote: AuthRemoteService(),
			userRemote: UserRemoteStore(),
			userLocal: UserLocalStore(),
			avatarRemote: AvatarRemoteStore()
		)

		// UseCase
		let useCase = AuthUseCase(repository: repository)

		// ViewModel
		self.authViewModel = AuthViewModel(useCase: useCase)
	}

	var body: some Scene {
		WindowGroup {
			AppRoot()
				.environment(
					\.managedObjectContext,
					persistenceController.container.viewContext
				)
				.environment(authViewModel)
		}
	}
}
