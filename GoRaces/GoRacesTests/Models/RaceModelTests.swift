import XCTest
@testable import GoRaces

final class RaceModelTests: XCTestCase {
    
    func generateRaceSummary(_ id: Int, _ raceType: String) -> RaceSummary {
        RaceSummary(raceID: "\(id)",
                    raceName: "\(id)",
                    raceNumber: id,
                    meetingID: "\(id)",
                    meetingName: "\(id)",
                    categoryID: raceType,
                    advertisedStart: AdvertisedStart(seconds: 1721374860 + id))
    }
    
    func testGivenGrayhoundRaceSummary_WhenConvertingToRaceModel_ThanConvertedCorrectly() throws {
        // Arrange
        let raceSummary = generateRaceSummary(1, RaceType.greyhound.rawValue)
        
        // Act
        let raceModel = RaceModel(raceSummary: raceSummary)
        
        // Assert
        XCTAssertEqual(raceModel.advertisedStartTime.timeIntervalSince1970, 1721374861)
        XCTAssertEqual(raceModel.meetingName, "1")
        XCTAssertEqual(raceModel.raceID, "1")
        XCTAssertEqual(raceModel.raceNumber, 1)
        XCTAssertEqual(raceModel.raceType, .greyhound)
        XCTAssertEqual(raceModel.raceName, "1")
    }
    
    func testGivenHorseRaceSummary_WhenConvertingToRaceModel_ThanConvertedCorrectly() throws {
        // Arrange
        let raceSummary = generateRaceSummary(1, RaceType.horse.rawValue)
        
        // Act
        let raceModel = RaceModel(raceSummary: raceSummary)
        
        // Assert
        XCTAssertEqual(raceModel.advertisedStartTime.timeIntervalSince1970, 1721374861)
        XCTAssertEqual(raceModel.meetingName, "1")
        XCTAssertEqual(raceModel.raceID, "1")
        XCTAssertEqual(raceModel.raceNumber, 1)
        XCTAssertEqual(raceModel.raceType, RaceType.horse)
        XCTAssertEqual(raceModel.raceName, "1")
    }
    
    func testGivenHarnessRaceSummary_WhenConvertingToRaceModel_ThanConvertedCorrectly() throws {
        // Arrange
        let raceSummary = generateRaceSummary(1, RaceType.harness.rawValue)
        
        // Act
        let raceModel = RaceModel(raceSummary: raceSummary)
        
        // Assert
        XCTAssertEqual(raceModel.advertisedStartTime.timeIntervalSince1970, 1721374861)
        XCTAssertEqual(raceModel.meetingName, "1")
        XCTAssertEqual(raceModel.raceID, "1")
        XCTAssertEqual(raceModel.raceNumber, 1)
        XCTAssertEqual(raceModel.raceType, RaceType.harness)
        XCTAssertEqual(raceModel.raceName, "1")
    }
    
    func testGivenNotSupportedRaceSummary_WhenConvertingToRaceModel_ThanConvertedCorrectly() throws {
        // Arrange
        let raceSummary = generateRaceSummary(1, "Something Else")
        
        // Act
        let raceModel = RaceModel(raceSummary: raceSummary)
        
        // Assert
        XCTAssertEqual(raceModel.advertisedStartTime.timeIntervalSince1970, 1721374861)
        XCTAssertEqual(raceModel.meetingName, "1")
        XCTAssertEqual(raceModel.raceID, "1")
        XCTAssertEqual(raceModel.raceNumber, 1)
        XCTAssertEqual(raceModel.raceType, .other)
        XCTAssertEqual(raceModel.raceName, "1")
    }
    
    func testGivenRaceStartsIn60sec_WhenCheckingTime_ThenIntervalIsGeneratedCorrectly() {
        // Arrange
        let raceSummary = generateRaceSummary(61, RaceType.greyhound.rawValue)
        let raceModel = RaceModel(raceSummary: raceSummary)
        
        // Act
        let actual = raceModel.intervalTill(time: Date(timeIntervalSince1970: 1721374861))
        
        // Assert
        XCTAssertEqual(actual, "01:00")
    }

    func testGivenRaceStarted60secAgo_WhenCheckingTime_ThenIntervalIsGeneratedCorrectly() {
        // Arrange
        let raceSummary = generateRaceSummary(-59, RaceType.greyhound.rawValue)
        let raceModel = RaceModel(raceSummary: raceSummary)
        
        // Act
        let actual = raceModel.intervalTill(time: Date(timeIntervalSince1970: 1721374861))
        
        // Assert
        XCTAssertEqual(actual, "-01:00")
    }

    func testGivenRaceStarted30SecAgo_WhenCheckingTime_ThenIntervalIsGeneratedCorrectly() {
        // Arrange
        let raceSummary = generateRaceSummary(-29, RaceType.greyhound.rawValue)
        let raceModel = RaceModel(raceSummary: raceSummary)
        
        // Act
        let actual = raceModel.intervalTill(time: Date(timeIntervalSince1970: 1721374861))
        
        // Assert
        XCTAssertEqual(actual, "-00:30")
    }

}
