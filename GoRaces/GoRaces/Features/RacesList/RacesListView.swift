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
        })  {
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

struct RaceFilterView: View {
    @Binding var raceTypes: [RaceType]
    @State var raceSelection: [Bool]
    @Environment(\.dismiss) var dismiss
    
    let relevantRaceTypes = RaceType.allCases.filter { $0 != .other }
    
    init(raceTypes: Binding<[RaceType]>) {
        self._raceTypes = raceTypes
        self._raceSelection = State(initialValue: relevantRaceTypes.map({ rt in
            raceTypes.wrappedValue.contains { selectedRT in
                selectedRT == rt
            }
        }))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Filter")
                .font(.title2)
                .frame(maxWidth: .infinity)
            ForEach(0..<raceSelection.count) { index in
                Toggle(isOn: $raceSelection[index], label: {
                    Text(relevantRaceTypes[index].icon) + Text("  \(relevantRaceTypes[index].title)")
                })
            }
            Spacer()
            Button {
                raceTypes.removeAll()
                for index in 0..<relevantRaceTypes.count {
                    if raceSelection[index] {
                        raceTypes.append(relevantRaceTypes[index])
                    }
                }
                dismiss()
            } label: {
                Text("Apply")
            }
            .frame(maxWidth: .infinity)

        }
        .padding()
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

#Preview {
    RaceFilterView(raceTypes: Binding.constant([RaceType.greyhound, RaceType.harness]))
}
