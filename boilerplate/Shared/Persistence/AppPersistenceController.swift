import CoreData

struct PersistenceController {
	static let shared = PersistenceController()
	let container: NSPersistentContainer
	
	init(useMemory: Bool = false) {
		container = NSPersistentContainer(name: "Model")
		
		if (useMemory) {
			container.persistentStoreDescriptions.first!.url = URL(
				fileURLWithPath: "/dev/null"
			)
		}
		
		container.viewContext.automaticallyMergesChangesFromParent = true
		container.loadPersistentStores { _, error in
			if let error = error {
				fatalError("Core Data error: \(error)")
			}
		}
	}
}
