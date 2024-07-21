import Foundation

class RacesListViewModel: ObservableObject {
    class RaceModelWrapper: ObservableObject {
        let raceModel: RaceModel
        let intervalDescription: String
        let intervalAccessibleDescription: String
        
        init(raceModel: RaceModel) {
            self.raceModel = raceModel
            self.intervalDescription = raceModel.intervalTill(time: Date.now)
            self.intervalAccessibleDescription = raceModel.acessibilityIntervalDescription(time: Date.now)
        }
    }
    
    private let _raceQueryService: RaceQueryServiceProtocol
    @Published var raceModels: [RaceModel] = []
    @Published var races: [RaceModelWrapper] = []
    @Published var selectedRaceTypes: [RaceType] = []
    @Published var errorMessage = ""
    @Published var updateTrigger = false
    
    init(_raceQueryService: RaceQueryServiceProtocol) {
        self._raceQueryService = _raceQueryService
    }
    
    @MainActor
    func refreshRaces() async {
        do {
            raceModels = (try await _raceQueryService.getRaces(for: [], max: -1))
                .sorted(by: { r1, r2 in
                    r1.advertisedStartTime < r2.advertisedStartTime
                })
            refreshTimeStamp()
            if races.isEmpty {
                errorMessage = "No races available"
            }
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }
    }
    
    @MainActor
    func refreshTimeStamp() {
        races = _raceQueryService.filterRaces(races: raceModels, raceTypes: selectedRaceTypes, max: 5).map{ RaceModelWrapper(raceModel: $0) }
    }
}
