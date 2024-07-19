import XCTest
@testable import GoRaces

final class RaceModelTests: XCTestCase {
    
    func generateDistanceType(_ id: Int) -> DistanceType {
        DistanceType(id: "\(id)", name: "\(id)", shortName: "SN\(id)", iconURI: "Icon\(id)")
    }
    
    func generateRaceForm(_ id: Int) -> RaceForm {
        RaceForm(distance: id, distanceType: generateDistanceType(id), distanceTypeID: "\(id)", trackCondition: generateDistanceType(id+1), trackConditionID: "\(id)", weather: nil, weatherID: nil, raceComment: "\(id)", additionalData: "\(id)", generated: id, silkBaseURL: "\(id)", raceCommentAlternative: "\(id)")
    }
    
    func generateRaceSummary(_ id: Int, _ raceType: String) -> RaceSummary {
        RaceSummary(raceID: "\(id)",
                    raceName: "\(id)",
                    raceNumber: id,
                    meetingID: "\(id)",
                    meetingName: "\(id)",
                    categoryID: raceType,
                    advertisedStart: AdvertisedStart(seconds: 1721374860 + id),
                    raceForm: generateRaceForm(id),
                    venueID: "\(id)",
                    venueName: "\(id)",
                    venueState: "\(id)",
                    venueCountry: "\(id)")
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

}
