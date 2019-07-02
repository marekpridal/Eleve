//
//  CloseView.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

struct CloseView : View {
    var body: some View {
        Group() {
            Image(systemName: "xmark")
            .accentColor(Color("DarkGray"))
        }
        .frame(width: 25, height: 25, alignment: .center)
        .background(Circle().fill(Color("LightGray")))
    }
}

#if DEBUG
struct CloseView_Previews : PreviewProvider {
    static var previews: some View {
        CloseView()
    }
}
#endif
