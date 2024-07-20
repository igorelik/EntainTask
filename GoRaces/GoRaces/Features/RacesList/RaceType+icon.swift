import SwiftUI

extension RaceType {
    var icon: Image {
        switch self {
        case .greyhound:
            return Image(.greyhoundRacing)
        case .harness:
            return Image(.harnessRacing)
        case .horse:
            return Image(.horseRacing)
        default:
            return Image(systemName: "questionmark.app")
        }
    }

}
