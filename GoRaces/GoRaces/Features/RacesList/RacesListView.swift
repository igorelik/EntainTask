import SwiftUI

struct RacesListView: View {
    @StateObject var viewModel: RacesListViewModel = ApplicationAssembly.resolver.resolve(RacesListViewModel.self)
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading) {
                ForEach(viewModel.raceModels, id: \.raceID) { raceModel in
                    SingleRaceView(raceModel: raceModel)
                }
            }
            .padding()
        }
        .onAppear() {
            Task {
                await viewModel.refreshRaces()
            }
        }
    }
}

struct SingleRaceView: View {
    let raceModel: RaceModel
    var body: some View {
        Text(raceModel.meetingName)
    }
}

#Preview {
    RacesListView()
}
