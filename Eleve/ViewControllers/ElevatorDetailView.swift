//
//  ElevatorDetailView.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

final class ElevatorDetailView : View {
    let viewModel: ElevatorDetailViewModel
    
    init(viewModel: ElevatorDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack() {
                VStack(alignment: .leading) {
                    Text(viewModel.elevator.name)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Text(viewModel.elevator.status)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                }
                Spacer()
                Button(action: { [weak self] in
                    self?.viewModel.delegate?.dismiss()
                }, label: {
                    CloseView()
                })
                .padding()
            }
            Divider()
            HStack(alignment: VerticalAlignment.bottom) {
                Button(action: { [weak self] in
                    self?.viewModel.favorite()
                }) {
                    CircleView(icon: Image(systemName: "star.fill"), color: Color("Orange"))
                }
                Spacer()
                Group {
                    Button(action: { [weak self] in
                        self?.viewModel.delegate?.navigate()
                    }, label: {
                        RoundedView(title: "NAVIGATE", color: Color("Blue"), icon: Image(systemName: "arrow.up"))
                    })
                }
                Spacer()
                Button(action: { [weak self] in
                    self?.viewModel.delegate?.report()
                }, label: {
                    RoundedView(title: "REPORT", color: Color("Red"), icon: Image(systemName: "arrow.up"))
                })
            }
            .padding(.trailing, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1...50) { element in
                        Button(action: {
                            //self?.viewModel.delegate?.showImageDetail(element.image)
                        }) {
                            Image(systemName: "selection.pin.in.out")
                                .frame(width: 139, height: 84, alignment: Alignment.center)
                                .background(Rectangle().fill(Color("Blue")).cornerRadius(6))
                        }
                    }
                }
            }
            Text("STATES")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .padding(.bottom, -10)
            List(1...50) { element in
                ElevatorStateView(elevatorState: ElevatorStateView.ElevatorState(working: Bool.random(), direction: "Z / Na nástupiště", lastUpdate: TimeInterval.random(in: 1000...10_000_000)))
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
            .padding(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: 25, leading: 20, bottom: 0, trailing: 0))
    }
}

#if DEBUG
struct ElevatorDetailView_Previews : PreviewProvider {
    static var previews: some View {
        ElevatorDetailView(viewModel: ElevatorDetailViewModel(elevator: ElevatorModel(name: "Dejvická", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35_000), delegate: nil))
    }
}
#endif
