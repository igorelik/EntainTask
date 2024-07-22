import Foundation

public class ConfigurationService: ConfigurationServiceProtocol {
    public var BackendAPIURI: String {
        let uri = Bundle.main.object(forInfoDictionaryKey: "BackendAPIURI")
        return uri as? String ?? "INVALID URI"
    }
}
