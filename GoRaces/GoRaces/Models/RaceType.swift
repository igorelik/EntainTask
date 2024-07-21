import Foundation

public enum RaceType: String, CaseIterable {
    case greyhound = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
    case harness = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    case horse = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    case other = ""
    
    var title: String {
        switch self {
        case .greyhound:
            return "Greyhound"
        case .harness:
            return "Harness"
        case .horse:
            return "Horse"
        default:
            return "Invalid"
        }
    }
}
