import Foundation

public struct RaceModel {
    
    let raceID: String
    let raceName: String
    let raceNumber: Int
    let raceType: RaceType
    let meetingName: String
    let advertisedStartTime: Date
    
    init(raceID: String, raceName: String, raceNumber: Int, raceType: RaceType, meetingName: String, advertisedStartTime: Date) {
        self.raceID = raceID
        self.raceName = raceName
        self.raceNumber = raceNumber
        self.raceType = raceType
        self.meetingName = meetingName
        self.advertisedStartTime = advertisedStartTime
    }
    
    init(raceSummary:RaceSummary) {
        self.raceID = raceSummary.raceID
        self.raceName = raceSummary.raceName
        self.raceNumber = raceSummary.raceNumber
        self.raceType = RaceType(rawValue: raceSummary.categoryID) ?? .other
        self.meetingName = raceSummary.meetingName
        self.advertisedStartTime = Date(timeIntervalSince1970: TimeInterval(raceSummary.advertisedStart.seconds))
    }
}
