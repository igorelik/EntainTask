import Foundation

public protocol RaceQueryServiceProtocol {
    func getRaces(for raceTypes: [RaceType], max: Int) async throws -> [RaceModel]
    func filterRaces(races: [RaceModel], raceTypes: [RaceType], max: Int) -> [RaceModel] 
}
