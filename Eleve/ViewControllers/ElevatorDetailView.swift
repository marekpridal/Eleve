//
//  ElevatorDetailView.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct ElevatorDetailView : View {
    let model: ElevatorDetailViewModel
    
    var body: some View {
        VStack() {
            HStack() {
                VStack(alignment: .leading) {
                    Text(model.elevator.name)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Text(model.elevator.status)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                }
                Spacer()
                Button(action: {
                    print("Button")
                }, label: {
                    CloseView()
                })
            }
                .padding()
            Divider()
            HStack(alignment: VerticalAlignment.bottom) {
                Button(action: {
                    print("Button")
                }) {
                    CircleView(icon: Image(systemName: "star.fill"), color: Color("Orange"))
                }
                Spacer()
                Group {
                    Button(action: {
                        print("Button")
                    }, label: {
                        RoundedView(title: "Navigovat", color: Color("Blue"), icon: Image(systemName: "arrow.up"))
                    })
                }
                Spacer()
                Button(action: {
                    print("Button")
                }, label: {
                    RoundedView(title: "Navigovat", color: Color("Red"), icon: Image(systemName: "arrow.up"))
                })
            }
            .padding(Edge.Set.leading, 20)
            .padding(Edge.Set.trailing, 20)
            ScrollView {
                HStack {
                    ForEach(1...50) { element in
                        Image(systemName: "selection.pin.in.out")
                        .frame(width: 139, height: 84, alignment: Alignment.center)
                        .background(Rectangle().fill(Color("Blue")).cornerRadius(6))
                    }
                }
                .padding(Edge.Set.leading, 20)
            }
            Text("Stav")
                .font(.system(size: 16))
                .fontWeight(.semibold)
            ScrollView {
                VStack {
                    ForEach(1...50) { element in
                        Text("\(element)")
                    }
                }
            }
        }
    }
}

#if DEBUG
@available(iOS 13, *)
struct ElevatorDetailView_Previews : PreviewProvider {
    static var previews: some View {
        ElevatorDetailView(model: ElevatorDetailViewModel(elevator: ElevatorModel(name: "Dejvická", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35_000), delegate: nil))
    }
}
#endif
