import Foundation

public struct RaceModel {
    
    let raceID: String
    let raceName: String
    let raceNumber: Int
    let raceType: RaceType
    let meetingName: String
    let advertisedStartTime: Date
    
    func intervalTill( time: Date) -> String {
        let secondsInterval = advertisedStartTime.timeIntervalSince1970 - time.timeIntervalSince1970
        let raceNotStarted = secondsInterval > 0
        let minutes = Int((secondsInterval.magnitude / 60).rounded(.down))
        let seconds = Int(secondsInterval.magnitude.truncatingRemainder(dividingBy: 60).magnitude)
        return "\(raceNotStarted ? "" : "-")\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }
    
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
