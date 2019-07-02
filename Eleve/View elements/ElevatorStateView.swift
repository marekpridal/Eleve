//
//  ElevatorStateView.swift
//  Eleve
//
//  Created by Marek Pridal on 02/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

struct ElevatorStateView : View {
    
    struct ElevatorState {
        let working: Bool
        let direction: String
        let lastUpdate: TimeInterval
        
        var formattedLastUpdate: String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full

            return formatter.localizedString(for: Date().addingTimeInterval(-lastUpdate), relativeTo: Date())
        }
    }
    
    let elevatorState: ElevatorState
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline, spacing: 15) {
                if elevatorState.working {
                    Image(systemName: "checkmark.circle")
                        .accentColor(Color("Green"))
                } else {
                    Image(systemName: "xmark.circle")
                        .accentColor(Color("Red"))
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    if elevatorState.working {
                        Text("WORKING")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                    } else {
                        Text("DOESNT_WORK")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                    }
                    Text(elevatorState.direction)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                }
                Spacer()
                Text(elevatorState.formattedLastUpdate)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
            }
        }
    }
}

#if DEBUG
struct ElevatorStateView_Previews : PreviewProvider {
    static var previews: some View {
        ElevatorStateView(elevatorState: ElevatorStateView.ElevatorState(working: true, direction: "Z / Na nástupiště", lastUpdate: 86_400))
    }
}
#endif
