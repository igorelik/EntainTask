import Swinject

class ApplicationAssembly {
    static var resolver: DIResolver!
    static func assemble(into diContainer: Container) {
        ServicesAssembly.assemble(into: diContainer)
        FeaturesAssembly.assemble(into: diContainer)
        resolver = DIResolver(diContainer: diContainer)
    }
}
