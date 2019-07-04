//
//  ButtonWithCircleIcon.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

struct ButtonWithCircleIcon : View {
    
    let image: Image
    let color: Color
    let title: LocalizedStringKey
    
    var body: some View {
        HStack {
            Group {
                image
                    .frame(width: 25, height: 25, alignment: .center)
                    .accentColor(color)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(color.opacity(20)
                        )
                )
            }
            .padding(.trailing, 10)
            Text(title)
                .color(color)
                .font(.system(size: 16))
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
    }
}

#if DEBUG
struct ButtonWithCircleIcon_Previews : PreviewProvider {
    static var previews: some View {
        ButtonWithCircleIcon(image: Image(systemName: "exclamationmark.bubble"), color: Color("Red"), title: "BROKEN_ELEVATOR")
    }
}
#endif
