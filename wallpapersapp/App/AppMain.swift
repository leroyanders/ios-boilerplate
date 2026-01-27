import SwiftUI
import CoreData
import FirebaseCore

@main
struct YourApp: App {
	let persistenceController = PersistenceController.shared
	
	init() {
		FirebaseApp.configure()
	}

	var body: some Scene {
		WindowGroup {
			AppRoot()
				.environment(
					\.managedObjectContext,
					persistenceController.container.viewContext
				)
				.environment(AuthViewModel())
		}
	}
}
