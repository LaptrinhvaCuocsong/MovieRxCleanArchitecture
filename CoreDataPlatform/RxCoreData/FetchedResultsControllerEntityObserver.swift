import CoreData
import Foundation
import RxSwift

final class FetchedResultsControllerEntityObserver<T: NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate {
    typealias Observer = AnyObserver<Result<[T], Error>>

    fileprivate let observer: Observer
    fileprivate let disposeBag = DisposeBag()
    fileprivate let frc: NSFetchedResultsController<T>

    init(observer: Observer, fetchRequest: NSFetchRequest<T>, managedObjectContext context: NSManagedObjectContext, sectionNameKeyPath: String?, cacheName: String?) {
        self.observer = observer

        frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                         managedObjectContext: context,
                                         sectionNameKeyPath: sectionNameKeyPath,
                                         cacheName: cacheName)
        super.init()

        context.perform {
            self.frc.delegate = self

            do {
                try self.frc.performFetch()
            } catch let e {
                observer.onNext(.failure(e))
            }

            self.sendNextElement()
        }
    }

    fileprivate func sendNextElement() {
        frc.managedObjectContext.perform {
            let entities = self.frc.fetchedObjects ?? []
            self.observer.onNext(.success(entities))
        }
    }

    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        sendNextElement()
    }
}

extension FetchedResultsControllerEntityObserver: Disposable {
    public func dispose() {
        frc.delegate = nil
    }
}
