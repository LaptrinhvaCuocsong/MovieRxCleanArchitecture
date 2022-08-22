import CoreData
import Foundation
import QueryKit
import RxSwift
import Utils

protocol AbstractRepository {
    associatedtype T: CoreDataRepresentable
    var context: NSManagedObjectContext { get }
    func query(fetchRequestCustom: ((NSFetchRequest<T.CoreDataType>) -> Void)?) -> Observable<Result<[T], Error>>
    func save(entity: T) -> Observable<Result<Bool, Error>>
    func save(entities: [T]) -> Observable<Result<Bool, Error>>
    func delete(entity: T) -> Observable<Result<Bool, Error>>
}

final class Repository<T: CoreDataRepresentable>: AbstractRepository where T == T.CoreDataType.DomainType {
    let context: NSManagedObjectContext
    private let scheduler: ContextScheduler

    init(context: NSManagedObjectContext) {
        self.context = context
        scheduler = ContextScheduler(context: context)
    }

    func query(fetchRequestCustom: ((NSFetchRequest<T.CoreDataType>) -> Void)? = nil) -> Observable<Result<[T], Error>> {
        let request = T.CoreDataType.fetchRequest()
        fetchRequestCustom?(request)
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

    func save(entities: [T]) -> Observable<Result<Bool, Error>> {
        let saveEntities = entities.map({ [unowned self] entity in save(entity: entity) })
        return Observable.combineLatest(saveEntities)
            .map { results in
                if results.contains(where: { $0.data == true }) {
                    return .success(true)
                } else {
                    return .failure(CDError.saveModelError)
                }
            }
    }

    func delete(entity: T) -> Observable<Result<Bool, Error>> {
        return entity.sync(in: context)
            .compactMap({ $0.data as? NSManagedObject })
            .flatMapLatest(context.rx.delete)
    }
}
