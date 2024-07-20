import Foundation

class RaceQueryServiceMock: RaceQueryServiceProtocol {
    let races: [RaceModel]
    
    init(races: [RaceModel]) {
        self.races = races
    }
    
    func getRaces(for raceTypes: [RaceType], max: Int) async throws -> [RaceModel] {
        races
    }
    
    public func filterRaces(races: [RaceModel], raceTypes: [RaceType], max: Int) -> [RaceModel] {
        races
    }
    
}
