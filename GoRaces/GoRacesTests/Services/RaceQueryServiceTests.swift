import XCTest
@testable import GoRaces

final class RaceQueryServiceTests: XCTestCase {
    private var service: RaceQueryService!
    
    func generateRaceModel(_ id: Int, raceType: RaceType) -> RaceModel {
        RaceModel(raceID: "\(id)", raceName: "Race \(id)", raceNumber: id, raceType: raceType, meetingName: "Meeting \(id)", advertisedStartTime: Date.now.advanced(by: TimeInterval(100*id)))
    }
    
    override func setUpWithError() throws {
        service = RaceQueryService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGivenNoFiltersDefinedsAndNegativeMaxSupplied_WhenFiltering_ThanAllRacesAreReturned() {
        // Arrange
        let races = [
            generateRaceModel(1, raceType: .greyhound),
            generateRaceModel(2, raceType: .horse),
            generateRaceModel(3, raceType: .harness),
            generateRaceModel(4, raceType: .greyhound),
            generateRaceModel(5, raceType: .horse),
            generateRaceModel(6, raceType: .harness),
            generateRaceModel(7, raceType: .greyhound),
            generateRaceModel(8, raceType: .horse),
            generateRaceModel(9, raceType: .harness),
            generateRaceModel(10, raceType: .greyhound),
            generateRaceModel(11, raceType: .horse),
            generateRaceModel(12, raceType: .harness),
        ]
        
        // Act
        let actual = service.filterRaces(races: races, raceTypes: [], max: -1)
        
        // Assert
        XCTAssertEqual(actual.count, races.count)
    }

    func testGivenNoFiltersDefinedsAndPositiveMaxSupplied_WhenFiltering_ThanOnlyFirstMaxRacesReturned() {
        // Arrange
        let races = [
            generateRaceModel(1, raceType: .greyhound),
            generateRaceModel(2, raceType: .horse),
            generateRaceModel(3, raceType: .harness),
            generateRaceModel(4, raceType: .greyhound),
        ]
        
        // Act
        let actual = service.filterRaces(races: races, raceTypes: [], max: 2)
        
        // Assert
        XCTAssertEqual(actual.count, 2)
        XCTAssertEqual(actual[0].raceID, races[0].raceID)
        XCTAssertEqual(actual[1].raceID, races[1].raceID)
    }

    func testGivenGreyhoubdFilter_WhenFiltering_ThanOnlyGreyhoundRacesAreReturned() {
        // Arrange
        let races = [
            generateRaceModel(1, raceType: .greyhound),
            generateRaceModel(2, raceType: .horse),
            generateRaceModel(3, raceType: .harness),
            generateRaceModel(4, raceType: .greyhound),
            generateRaceModel(5, raceType: .horse),
            generateRaceModel(6, raceType: .harness),
            generateRaceModel(7, raceType: .greyhound),
            generateRaceModel(8, raceType: .horse),
            generateRaceModel(9, raceType: .harness),
            generateRaceModel(10, raceType: .greyhound),
            generateRaceModel(11, raceType: .horse),
            generateRaceModel(12, raceType: .harness),
            generateRaceModel(13, raceType: .greyhound),
            generateRaceModel(14, raceType: .greyhound),
        ]
        
        // Act
        let actual = service.filterRaces(races: races, raceTypes: [.greyhound], max: 5)
        
        // Assert
        XCTAssertEqual(actual.count, 5)
        XCTAssertTrue(actual.allSatisfy{ $0.raceType == .greyhound  })
        XCTAssertTrue(actual.allSatisfy{ $0.raceID != races.last!.raceID  })
    }

}
