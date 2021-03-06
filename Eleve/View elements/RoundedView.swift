//
//  RoundedView.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

struct RoundedView : View {
    
    let title: LocalizedStringKey
    let color: Color
    let icon: Image
    
    var body: some View {
        Group() {
            HStack() {
                icon
                .accentColor(color)
                Text(title)
                .foregroundColor(color)
            }
        }
        .padding(EdgeInsets(top: 13, leading: 23, bottom: 13, trailing: 23))
        .background(Rectangle()
        .fill(color.opacity(0.1))
        .cornerRadius(21))
    }
}

#if DEBUG
struct RoundedButtonView_Previews : PreviewProvider {
    static var previews: some View {
        RoundedView(title: "Navigovat", color: Color("Red"), icon: Image(systemName: "arrow.up"))
    }
}
#endif
