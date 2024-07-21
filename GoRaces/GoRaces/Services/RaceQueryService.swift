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
            .sorted(by: { r1, r2 in
                r1.advertisedStartTime < r2.advertisedStartTime
            })
            .filter { $0.advertisedStartTime.timeIntervalSince(Date.now) > -60 }
        if raceTypes.isEmpty || raceTypes.count == RaceType.allCases.count - 1 {
            // return all relevant races
            return relevantRaces.prefix(max > 0 ? max : relevantRaces.count).filter { _ in true }
        }
        // filter by selected race types
        return relevantRaces.filter { race in
            raceTypes.contains(where: { rt in
                rt == race.raceType
            })
        }
        .prefix(max).filter { _ in true }
    }
    
    public func getRaces(for raceTypes: [RaceType], max: Int) async throws -> [RaceModel] {
        // TODO: refactor to use config to build URL
        let url = "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=\(15*RaceType.allCases.count)"
        let data = try await fetchData(RacesDTO.self, for: URLRequest(url: URL(string: url)!))
        return filterRaces(races: data.data.raceSummaries.values
            .compactMap{ RaceModel(raceSummary: $0) }, raceTypes: raceTypes, max: max)
    }
}
