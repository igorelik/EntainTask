import Swinject

class ServicesAssembly {
    private static let _raceQueryService = RaceQueryService()
    
    static func assemble(into diContainer: Container) {
        diContainer.register(RaceQueryServiceProtocol.self) { _ in
                _raceQueryService
        }
    }
}
