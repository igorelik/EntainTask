import SwiftUI

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
    RaceFilterView(raceTypes: Binding.constant([RaceType.greyhound, RaceType.harness]))
}

