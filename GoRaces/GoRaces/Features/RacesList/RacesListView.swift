import SwiftUI

struct RacesListView: View {
    @StateObject var viewModel: RacesListViewModel = ApplicationAssembly.resolver.resolve(RacesListViewModel.self)
    @State var isFilterViewPresented = false
    private let timeStampTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let refreshTimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            ZStack {
                Image(.nedsLogo)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(maxHeight: 100)
                    .padding(.top)
                    .accessibilityLabel("Neds logo")
            }
                .frame(maxWidth: .infinity)
                .background(Color.nedsBg)
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundStyle(Color.nedsBg)
                    .font(.title3)
            }
            LazyVStack (alignment: .leading) {
                ForEach(viewModel.races, id: \.raceModel.raceID) { raceModel in
                    SingleRaceView(race: raceModel)
                }
            }
            .padding()
        }
        .task {
            await viewModel.refreshRaces()
        }
        .onReceive(timeStampTimer) { _ in
            withAnimation {            viewModel.refreshTimeStamp()
            }
        }
        .onReceive(refreshTimer) { _ in
            Task {
                await viewModel.refreshRaces()
            }
        }
        .sheet(isPresented: $isFilterViewPresented, onDismiss: {
                withAnimation {            viewModel.refreshTimeStamp()
                }
            }
        ) {
            if #available(iOS 16.0, *) {
                RaceFilterView(raceTypes: $viewModel.selectedRaceTypes)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            } else {
                RaceFilterView(raceTypes: $viewModel.selectedRaceTypes)
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationBarItems(trailing: Button(action: {
            isFilterViewPresented = true
        }, label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .foregroundStyle(Color.primary)
        }))
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
                        .foregroundStyle(Color.nedsBg)
                        .accessibilityLabel("\(race.raceModel.raceType.title) race \(race.raceModel.meetingName). Race \(race.raceModel.raceNumber)")
                    Text("Race: \(race.raceModel.raceNumber)")
                        .accessibilityHidden(true)
                }
                Spacer()
                Text(race.intervalDescription)
                    .accessibilityLabel(race.intervalAccessibleDescription)
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
    return NavigationView {
        RacesListView(viewModel: getViewModel())
    }
}
