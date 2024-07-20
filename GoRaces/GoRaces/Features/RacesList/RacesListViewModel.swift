import Foundation

class RacesListViewModel: ObservableObject {
    private let _raceQueryService: RaceQueryServiceProtocol
    @Published var raceModels: [RaceModel] = []
    @Published var selectedRaceTypes: [RaceType] = []
    @Published var errorMessage = ""
    
    init(_raceQueryService: RaceQueryServiceProtocol) {
        self._raceQueryService = _raceQueryService
    }
    
    @MainActor
    func refreshRaces() async {
        do {
            raceModels = try await _raceQueryService.getRaces(for: selectedRaceTypes, max: 5)
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }
    }
}
