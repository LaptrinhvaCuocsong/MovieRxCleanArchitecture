import CoreData
import Foundation
import QueryKit
import RxSwift
import Utils

protocol AbstractRepository {
    associatedtype T
    func query(with predicate: NSPredicate?,
               sortDescriptors: [NSSortDescriptor]?) -> Observable<Result<[T], Error>>
    func save(entity: T) -> Observable<Result<Bool, Error>>
    func delete(entity: T) -> Observable<Result<Bool, Error>>
}

final class Repository<T: CoreDataRepresentable>: AbstractRepository where T == T.CoreDataType.DomainType {
    private let context: NSManagedObjectContext
    private let scheduler: ContextScheduler

    init(context: NSManagedObjectContext) {
        self.context = context
        scheduler = ContextScheduler(context: context)
    }

    func query(with predicate: NSPredicate? = nil,
               sortDescriptors: [NSSortDescriptor]? = nil) -> Observable<Result<[T], Error>> {
        let request = T.CoreDataType.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return context.rx.entities(fetchRequest: request)
            .map({ $0.mapToDomain() })
            .subscribe(on: scheduler)
    }

    func save(entity: T) -> Observable<Result<Bool, Error>> {
        return entity.sync(in: context)
            .mapToVoid()
            .flatMapLatest(context.rx.save)
            .subscribe(on: scheduler)
    }

    func delete(entity: T) -> Observable<Result<Bool, Error>> {
        return entity.sync(in: context)
            .compactMap({ $0.data as? NSManagedObject })
            .flatMapLatest(context.rx.delete)
    }
}
