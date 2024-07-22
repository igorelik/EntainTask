import Foundation

class RacesListViewModel: ObservableObject {
    struct RaceModelWrapper {
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
    
    init(_raceQueryService: RaceQueryServiceProtocol) {
        self._raceQueryService = _raceQueryService
    }
    
    @MainActor
    func refreshRaces() async {
        do {
            raceModels = (try await _raceQueryService.getRaces(for: [], max: -1))
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
