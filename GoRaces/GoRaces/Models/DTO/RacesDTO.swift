import Foundation

// MARK: - RacesDTO
struct RacesDTO: Codable {
    let status: Int
    let data: RacesData
    let message: String
}

// MARK: - RacesData
struct RacesData: Codable {
    let nextToGoIDS: [String]
    let raceSummaries: [String: RaceSummary]

    enum CodingKeys: String, CodingKey {
        case nextToGoIDS = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
}

// MARK: - RaceSummary
struct RaceSummary: Codable {
    let raceID, raceName: String
    let raceNumber: Int
    let meetingID, meetingName, categoryID: String
    let advertisedStart: AdvertisedStart
    let raceForm: RaceForm
    let venueID, venueName, venueState: String
    let venueCountry: String

    enum CodingKeys: String, CodingKey {
        case raceID = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingID = "meeting_id"
        case meetingName = "meeting_name"
        case categoryID = "category_id"
        case advertisedStart = "advertised_start"
        case raceForm = "race_form"
        case venueID = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
    }
}

// MARK: - AdvertisedStart
struct AdvertisedStart: Codable {
    let seconds: Int
}

// MARK: - RaceForm
struct RaceForm: Codable {
    let distance: Int
    let distanceType: DistanceType
    let distanceTypeID: String
    let trackCondition: DistanceType?
    let trackConditionID: String?
    let weather: DistanceType?
    let weatherID: String?
    let raceComment, additionalData: String?
    let generated: Int
    let silkBaseURL: String?
    let raceCommentAlternative: String?

    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
        case distanceTypeID = "distance_type_id"
        case trackCondition = "track_condition"
        case trackConditionID = "track_condition_id"
        case weather
        case weatherID = "weather_id"
        case raceComment = "race_comment"
        case additionalData = "additional_data"
        case generated
        case silkBaseURL = "silk_base_url"
        case raceCommentAlternative = "race_comment_alternative"
    }
}

// MARK: - DistanceType
struct DistanceType: Codable {
    let id: String
    let name: String
    let shortName: String
    let iconURI: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case shortName = "short_name"
        case iconURI = "icon_uri"
    }
}

