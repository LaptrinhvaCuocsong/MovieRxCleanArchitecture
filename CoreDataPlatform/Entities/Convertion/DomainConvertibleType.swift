import CoreData
import Foundation
import QueryKit
import RxSwift

protocol DomainConvertibleType {
    associatedtype DomainType

    func asDomain() -> DomainType
}

protocol CoreDataRepresentable {
    associatedtype CoreDataType: Persistable

    var uid: String { get }

    func sync(in context: NSManagedObjectContext) -> Observable<Result<CoreDataType, Error>>
    func update(entity: CoreDataType)
}

extension CoreDataRepresentable {
    func sync(in context: NSManagedObjectContext) -> Observable<Result<CoreDataType, Error>> {
        return context.rx.sync(entity: self, update: update)
    }
}
