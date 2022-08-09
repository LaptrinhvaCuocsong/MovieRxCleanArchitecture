import Domain
import Foundation

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let coreDataStack = CoreDataStack()

    public init() {
    }

    public func makeMoviesUseCase() -> Domain.MoviesUseCase? {
        return nil
    }

    public func makeMovieConfigurationUseCase() -> Domain.MovieConfigurationUseCase? {
        return MovieConfigurationUseCase(repository: RepositoryProvider().makeMovieConfigurationRepository())
    }
}
