//
//  RootView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 20/02/2021.
//

import SwiftUI

struct RootView: View {
    @State private var isMeditationViewVisible = false

    var body: some View {
        if isMeditationViewVisible {
            MeditationView(mood: .chillOut)
                .transition(.opacity)
        } else {
            FeelingView(onSelectDone: {
                isMeditationViewVisible.toggle()
            })
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
