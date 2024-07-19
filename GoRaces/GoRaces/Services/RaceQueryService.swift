import Foundation

public class RaceQueryService: RaceQueryServiceProtocol {
    private func fetchData<T: Decodable>(_ t: T.Type, for urlRequest: URLRequest) async throws -> T {
        do {
            let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
            if let response = httpResponse as? HTTPURLResponse {
                if (200...299).contains(response.statusCode) {
                    let decoder = JSONDecoder()
                    return try decoder.decode(T.self, from: data)
                } else {
                    throw NetworkError.apiError(statusCode: response.statusCode)
                }
            }
            
            throw NetworkError.transportError(String.init(data: data, encoding: .utf8))
            
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error: error)
        }
    }
    
    public func filterRaces(races: [RaceModel], raceTypes: [RaceType], max: Int) -> [RaceModel] {
        let relevantRaces = races.filter{ $0.raceType != .other }
        if raceTypes.isEmpty {
            // return all relevant races
            return relevantRaces
        }
        // filter by selected race types
        return races.filter { race in
            raceTypes.contains(where: { rt in
                rt == race.raceType
            })
        }
    }
    
    public func getRaces(for raceTypes: [RaceType], max: Int) async throws -> [RaceModel] {
        // TODO: refactor to use config to build URL
        let url = "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=50"
        let data = try await fetchData(RacesDTO.self, for: URLRequest(url: URL(string: url)!))
        return filterRaces(races: data.data.raceSummaries.values
            .compactMap{ RaceModel(raceSummary: $0) }, raceTypes: raceTypes, max: max)
    }
    
    
}
