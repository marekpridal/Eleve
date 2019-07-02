//
//  CircleView.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

struct CircleView : View {
    
    let icon: Image
    let color: Color
    
    var body: some View {
        Group() {
            icon
            .accentColor(color)
        }
        .frame(width: 42, height: 42, alignment: .center)
        .background(Circle().fill(color.opacity(20)))
    }
}

#if DEBUG
struct CircleView_Previews : PreviewProvider {
    static var previews: some View {
        CircleView(icon: Image(systemName: "star.fill"), color: Color("Orange"))
    }
}
#endif
