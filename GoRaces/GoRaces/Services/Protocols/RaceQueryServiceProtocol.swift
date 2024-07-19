import Foundation

public protocol RaceQueryServiceProtocol {
    func getRaces(for raceTypes: [RaceType], max: Int) async throws -> [RaceModel]
}
