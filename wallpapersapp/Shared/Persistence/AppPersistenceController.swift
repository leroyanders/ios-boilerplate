import CoreData

struct PersistenceController {
	static let shared = PersistenceController()
	let container: NSPersistentContainer

	init(inMemory: Bool = false, modelName: String = "Model") {
		container = NSPersistentContainer(name: modelName)

		if inMemory {
			container.persistentStoreDescriptions.first?.url =
				URL(fileURLWithPath: "/dev/null")
		}

		container.loadPersistentStores { _, error in
			if let error = error {
				fatalError("Unresolved error \(error)")
			}
		}

		// Рекомендуемая настройка
		container.viewContext.automaticallyMergesChangesFromParent = true
	}
}
