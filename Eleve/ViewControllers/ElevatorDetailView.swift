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
        VStack(alignment: .leading) {
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
            ScrollView {
                VStack(spacing: 15) {
                    HStack(alignment: VerticalAlignment.bottom) {
                        Button(action: { [weak self] in
                            self?.viewModel.favorite()
                        }) {
                            CircleView(icon: Image(systemName: "star.fill"), color: Color("Orange"))
                        }
                        Spacer()
                        Group {
                            Button(action: { [weak self] in
                                guard let self = self else { return }
                                self.viewModel.delegate?.navigate(elevator: self.viewModel.elevator)
                                }, label: {
                                    RoundedView(title: "NAVIGATE", color: Color("Blue"), icon: Image(systemName: "arrow.up"))
                            })
                        }
                        Spacer()
                        Button(action: { [weak self] in
                            guard let self = self else { return }
                            self.viewModel.delegate?.report(elevator: self.viewModel.elevator)
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
                    VStack(alignment: .leading) {
                        Text("STATES")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        ForEach(1...50) { element in
                            ElevatorStateView(elevatorState: ElevatorStateView.ElevatorState(working: Bool.random(), direction: "Z / Na nástupiště", lastUpdate: TimeInterval.random(in: 1000...10_000_000)))
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 20))
                            Divider()
                                .padding(.leading, 35)
                        }
                        Text("INFORMATION")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        VStack(spacing: 10) {
                            KeyValueView(key: "VEHICLE_TYPE", value: viewModel.elevator.type)
                            KeyValueView(key: "DURATION", value: viewModel.elevator.formattedDuration)
                        }
                        .padding(.trailing, 20)
                    }
                }
                .padding(.bottom, 15)
            }
        }
        .padding(.leading, 20)
    }
}

#if DEBUG
struct ElevatorDetailView_Previews : PreviewProvider {
    static var previews: some View {
        ElevatorDetailView(viewModel: ElevatorDetailViewModel(elevator: ElevatorModel(name: "Dejvická", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35), delegate: nil))
    }
}
#endif
