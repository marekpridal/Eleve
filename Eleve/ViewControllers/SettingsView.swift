//
//  SettingsView.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

struct SettingsView : View {
    
    let viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            TitleAndSubtitleWithSwitch(switchValue: true, title: "FAVORITE_STATIONS_STATES_TITLE", subtitle: "FAVORITE_STATIONS_STATES_SUBTITLE")
            .padding(.bottom, 25)
            TitleAndSubtitleWithSwitch(switchValue: false, title: "USER_ACTIVITY_TITLE", subtitle: "USER_ACTIVITY_SUBTITLE")
            .padding(.bottom, 25)
            Divider()
            ButtonWithCircleIcon(image: Image(systemName: "questionmark"), color: Color("Blue"), title: "RECOMMEND_IMPROVEMENT")
            ButtonWithCircleIcon(image: Image(systemName: "trash"), color: Color("Red"), title: "DELETE_ALL_SHARED_DATA")
            Spacer()
        }
        .padding()
        .navigationBarTitle("SETTINGS_TITLE", displayMode: .large)
    }
}

#if DEBUG
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(delegate: nil))
    }
}
#endif
