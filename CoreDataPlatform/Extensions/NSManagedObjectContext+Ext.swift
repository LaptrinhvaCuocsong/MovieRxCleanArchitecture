import CoreData
import Foundation

extension NSManagedObjectContext {
    func create<T: NSFetchRequestResult>() -> T {
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self),
                                                               into: self) as? T else {
            fatalError()
        }
        return entity
    }
}
