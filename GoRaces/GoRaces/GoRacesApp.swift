import SwiftUI
import Swinject

@main
struct GoRacesApp: App {
    init() {
        let diContainer = Container()
        ApplicationAssembly.assemble(into: diContainer)
    }
    
    var body: some Scene {
        WindowGroup {
            // TODO: replace with NavigationStack when iOS 15 support can be dropped
            NavigationView {
                RacesListView()
            }
        }
    }
}
