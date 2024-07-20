import SwiftUI

struct RacesListView: View {
    @StateObject var viewModel: RacesListViewModel = ApplicationAssembly.resolver.resolve(RacesListViewModel.self)
    private let timeStampTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let refreshTimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading) {
                ForEach(viewModel.races, id: \.raceModel.raceID) { raceModel in
                    SingleRaceView(race: raceModel)
                }
            }
            .padding()
        }
        .onAppear() {
            Task {
                await viewModel.refreshRaces()
            }
        }
        .onReceive(timeStampTimer) { _ in
            viewModel.refreshTimeStamp()
        }
        .onReceive(refreshTimer) { _ in
            Task {
                await viewModel.refreshRaces()
            }
        }
    }
}

struct SingleRaceView: View {
    let race: RacesListViewModel.RaceModelWrapper
    var body: some View {
        VStack{
            HStack {
                VStack(alignment: .leading ) {
                    (Text(race.raceModel.raceType.icon) +  Text(" \(race.raceModel.meetingName)"))
                        .bold()
                        .font(.title3)
                    Text("Race: \(race.raceModel.raceNumber)")
                }
                Spacer()
                Text(race.intervalDescription)
            }
            Divider()
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    func generateRaceModel(_ id: Int, raceType: RaceType) -> RaceModel {
        RaceModel(raceID: "\(id)", raceName: "Race \(id)", raceNumber: id, raceType: raceType, meetingName: "Meeting \(id)", advertisedStartTime: Date.now.advanced(by: TimeInterval(100*id)))
    }
    
    func getViewModel() -> RacesListViewModel {
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
        let service = RaceQueryServiceMock(races: races)
        return RacesListViewModel(_raceQueryService: service)
    }
    return RacesListView(viewModel: getViewModel())
}
