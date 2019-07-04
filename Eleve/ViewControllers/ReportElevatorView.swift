//
//  ReportElevatorView.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

final class ReportElevatorView : View {
    let viewModel: ReportElevatorViewModel
    
    init(viewModel: ReportElevatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ELEVATOR_HEADER")
                .font(.system(size: 16))
                .fontWeight(.semibold)
            ElevatorCellViewRepresentable(elevator: viewModel.elevator)
            .frame(height: 70)
            Divider()
            ButtonWithCircleIcon(image: Image(systemName: "exclamationmark.bubble"), color: Color("Red"), title: "BROKEN_ELEVATOR")
            ButtonWithCircleIcon(image: Image(systemName: "exclamationmark"), color: Color("Red"), title: "WRONG_STATUS")
            Spacer()
        }
        .padding()
        .navigationBarTitle("REPORT_TITLE")
            .navigationBarItems(leading: Button(action: { [weak self] in
                self?.viewModel.delegate?.dismissReport()
            }, label: {
                Text("DISMISS")
            }))
    }
}

#if DEBUG
struct ReportElevatorView_Previews : PreviewProvider {
    static var previews: some View {
        ReportElevatorView(viewModel: ReportElevatorViewModel(elevator: ElevatorModel(name: "Dejvická", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35), delegate: nil))
    }
}
#endif
