import Foundation

struct RacesDTO: Codable {
    let status: Int
    let data: RacesData
    let message: String
}

struct RacesData: Codable {
    let nextToGoIDS: [String]
    let raceSummaries: [String: RaceSummary]

    enum CodingKeys: String, CodingKey {
        case nextToGoIDS = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
}

struct RaceSummary: Codable {
    let raceID, raceName: String
    let raceNumber: Int
    let meetingID, meetingName, categoryID: String
    let advertisedStart: AdvertisedStart

    enum CodingKeys: String, CodingKey {
        case raceID = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingID = "meeting_id"
        case meetingName = "meeting_name"
        case categoryID = "category_id"
        case advertisedStart = "advertised_start"
    }
}

struct AdvertisedStart: Codable {
    let seconds: Int
}

