//
//  KeyValueView.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

struct KeyValueView : View {
    
    let key: LocalizedStringKey
    let value: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(key)
                .font(.system(size: 14))
                .fontWeight(.medium)
            Spacer()
            Text(value)
                .font(.system(size: 14))
                .fontWeight(.semibold)
        }
        .frame(alignment: .leading)
    }
}

#if DEBUG
struct KeyValueView_Previews : PreviewProvider {
    static var previews: some View {
        KeyValueView(key: "VEHICLE_TYPE", value: "Výtah")
    }
}
#endif
