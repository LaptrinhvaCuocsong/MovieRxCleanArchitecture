import CoreData
import Foundation
import QueryKit
import RxSwift

protocol Persistable: NSFetchRequestResult, DomainConvertibleType {
    static var entityName: String { get }
    static func fetchRequest() -> NSFetchRequest<Self>
}

extension Persistable {
    static var primaryAttribute: Attribute<String> {
        return Attribute("uid")
    }
}
