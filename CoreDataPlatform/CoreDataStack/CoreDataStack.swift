import CoreData
import Foundation

final class CoreDataStack {
    static let shared = CoreDataStack()

    let context: NSManagedObjectContext
    private let storeCoordinator: NSPersistentStoreCoordinator

    private init() {
        let bundle = Bundle(for: CoreDataStack.self)
        guard let url = bundle.url(forResource: "Model", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError()
        }
        storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = storeCoordinator
        migrateStore(version: 2)
    }

    private func migrateStore(version: Int) {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError()
        }
        let storeUrl = url.appendingPathComponent("Model_v\(version).sqlite")
        print("📂📂📂 storeUrl = \(storeUrl.absoluteString)")
        do {
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                    configurationName: nil,
                                                    at: storeUrl,
                                                    options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
}
