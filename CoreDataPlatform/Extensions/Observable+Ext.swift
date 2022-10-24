import Foundation
import RxSwift

extension Result where Success: Sequence, Success.Element: DomainConvertibleType {
    func mapToDomain() -> Result<[Success.Element.DomainType], Error> {
        switch self {
        case let .success(success):
            return .success(success.mapToDomain())
        case let .failure(failure):
            return .failure(failure)
        }
    }
}

extension Result where Success: DomainConvertibleType {
    func mapToDomain() -> Result<Success.DomainType, Error> {
        switch self {
        case let .success(success):
            return .success(success.asDomain())
        case let .failure(failure):
            return .failure(failure)
        }
    }
}

extension Sequence where Iterator.Element: DomainConvertibleType {
    typealias Element = Iterator.Element
    func mapToDomain() -> [Element.DomainType] {
        return map {
            return $0.asDomain()
        }
    }
}
