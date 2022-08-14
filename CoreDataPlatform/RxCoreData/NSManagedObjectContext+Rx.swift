import CoreData
import Foundation
import QueryKit
import RxSwift

extension Reactive where Base: NSManagedObjectContext {
    /**
     Executes a fetch request and returns the fetched objects as an `Observable` array of `NSManagedObjects`.
     - parameter fetchRequest: an instance of `NSFetchRequest` to describe the search criteria used to retrieve data from a persistent store
     - parameter sectionNameKeyPath: the key path on the fetched objects used to determine the section they belong to; defaults to `nil`
     - parameter cacheName: the name of the file used to cache section information; defaults to `nil`
     - returns: An `Observable` array of `NSManagedObjects` objects that can be bound to a table view.
     */
    func entities<T: NSFetchRequestResult>(fetchRequest: NSFetchRequest<T>) -> Observable<Result<[T], Error>> {
        return Observable<Result<[T], Error>>.create { observer in
            do {
                let result = try self.base.fetch(fetchRequest)
                observer.onNext(.success(result))
            } catch {
                observer.onNext(.failure(error))
            }
            return Disposables.create()
        }
    }

    func save() -> Observable<Result<Bool, Error>> {
        return Observable<Result<Bool, Error>>.create { observer in
            do {
                try self.base.save()
                observer.onNext(.success(true))
            } catch {
                observer.onNext(.failure(error))
            }
            return Disposables.create()
        }
    }

    func delete<T: NSManagedObject>(entity: T) -> Observable<Result<Bool, Error>> {
        return Observable<Result<Bool, Error>>.create { observer in
            self.base.delete(entity)
            observer.onNext(.success(true))
            return Disposables.create()
        }.flatMapLatest { _ in
            self.save()
        }
    }

    func first<T: NSFetchRequestResult>(ofType: T.Type = T.self, with predicate: NSPredicate) -> Observable<Result<T?, Error>> {
        return Observable<Result<T?, Error>>.create { observer in
            let entityName = String(describing: T.self)
            let request = NSFetchRequest<T>(entityName: entityName)
            request.predicate = predicate
            do {
                let result = try self.base.fetch(request).first
                observer.onNext(.success(result))
            } catch {
                observer.onNext(.failure(error))
            }
            return Disposables.create {}
        }
    }

    func sync<C: CoreDataRepresentable, P>(entity: C,
                                           update: @escaping (P) -> Void) -> Observable<Result<P, Error>> where C.CoreDataType == P {
        let predicate: NSPredicate = P.primaryAttribute == entity.uid
        return first(ofType: P.self, with: predicate)
            .map({ result -> Result<P, Error> in
                switch result {
                case let .success(obj):
                    let object = obj ?? self.base.create()
                    update(object)
                    return .success(object)
                case let .failure(error):
                    return .failure(error)
                }
            })
    }
}
