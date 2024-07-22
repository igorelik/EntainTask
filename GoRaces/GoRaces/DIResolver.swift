import Swinject
import Combine

// Number of helper functions here for future use to enable fetures like navigation to a child view
// i.e. resolve classes with parameters based on the context, 
// e.g. details page with a detail entity ID as a parameter
class DIResolver {
    private let diContainer: Container

    init(diContainer: Container) {
        self.diContainer = diContainer
    }

    public func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = diContainer.resolve(serviceType, name: nil) else {
            preconditionFailure("cannot find \(serviceType) in diContainer.resolve")
        }
        return service
    }

    public func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
        guard let service = diContainer.resolve(serviceType, name: nil, argument: argument) else {
            preconditionFailure("cannot find \(serviceType) in diContainer.resolve")
        }
        return service
    }

    public func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        guard let service = diContainer.resolve(serviceType, name: nil, arguments: arg1, arg2) else {
            preconditionFailure("cannot find \(serviceType) in diContainer.resolve")
        }
        return service
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service {
        guard let service = diContainer.resolve(serviceType, name: nil, arguments: arg1, arg2, arg3) else {
            preconditionFailure("cannot find \(serviceType) in diContainer.resolve")
        }
        return service
    }
}
