import Foundation
import Swinject

class FeaturesAssembly {
    static func assemble(into diContainer: Container) {
        diContainer.register(RacesListViewModel.self) { _ in
            RacesListViewModel(_raceQueryService: diContainer.resolve(RaceQueryServiceProtocol.self)!)
        }
    }
}
