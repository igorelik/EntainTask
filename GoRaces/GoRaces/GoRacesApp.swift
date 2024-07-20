import SwiftUI
import Swinject

@main
struct GoRacesApp: App {
//    let diResolver: DIResolver
//    
    init() {
        let diContainer = Container()
        ApplicationAssembly.assemble(into: diContainer)
//        diResolver = DIResolver(diContainer: diContainer)
    }
    
    var body: some Scene {
        WindowGroup {
            RacesListView()
//                .environmentObject(diResolver)
        }
    }
}
