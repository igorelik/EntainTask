import Swinject

class ServicesAssembly {
    private static let _configurationService = ConfigurationService()
    private static let _raceQueryService = RaceQueryService(_configurationService: _configurationService)

    static func assemble(into diContainer: Container) {
        diContainer.register(ConfigurationServiceProtocol.self) { _ in
                _configurationService
        }
        diContainer.register(RaceQueryServiceProtocol.self) { _ in
            _raceQueryService
        }
    }
}
