//
//  TitleAndSubtitleWithSwitch.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

struct TitleAndSubtitleWithSwitch : View {
    
    @State var switchValue: Bool
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                Text(subtitle)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
            }
            .lineLimit(nil)
            // TODO change toggle color
            Toggle(isOn: $switchValue) {
                Text("")
            }
            .accentColor(Color("Orange"))
        }
    }
}

#if DEBUG
struct TitleAndSubtitleWithSwitch_Previews : PreviewProvider {
    static var previews: some View {
        TitleAndSubtitleWithSwitch(switchValue: true, title: "Stav oblíbených stanic", subtitle: "Nechte si oznamovat stav vašich oblíbených stanic")
    }
}
#endif
