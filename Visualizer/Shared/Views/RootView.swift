//
//  RootView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 20/02/2021.
//

import SwiftUI

struct RootView: View {
    @State private var isMeditationViewVisible = false
    @State private var feeling: Feeling?

    var body: some View {
        if isMeditationViewVisible {
            MeditationView(mood: .chillOut)
                .transition(.opacity)
        } else if let feeling = feeling {
            IntendsView(feeling: feeling)
                .onTapGesture {
                    isMeditationViewVisible.toggle()
                }
        } else {
            FeelingView(onSelectDone: { feeling in
                self.feeling = feeling
            })
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
