//
//  RootView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 20/02/2021.
//

import SwiftUI

struct RootView: View {
    
    @State private var isMeditationViewVisible = false
    @State private var isMeditationCompleted = false
    @State private var reviewCompleted = false
    @State private var isFeelingViewVisible = false
    @State private var currentFeeling: Feeling = .neutral
    @State private var afterFeeling: Feeling = .neutral
    @State private var currentIntend: Intend = .chillOut

    @Namespace private var animation

    var body: some View {
        if isMeditationViewVisible {
            MeditationView(intend: currentIntend) {
                isFeelingViewVisible.toggle()
                isMeditationViewVisible.toggle()
                isMeditationCompleted.toggle()
            }
            .transition(.opacity)
        } else if isFeelingViewVisible {
            IntendsView(feeling: $currentFeeling, transitionNamespace: animation, onSelectBack: {
                withAnimation(.linear(duration: 0.33)) {
                    isFeelingViewVisible.toggle()
                }
            }, onSelectIntend: { intend in
                currentIntend = intend
                isMeditationViewVisible.toggle()
            })
        } else {
            FeelingView(with: currentFeeling,
                        title: isMeditationCompleted ? Strings.howAreYouFeelingNow : Strings.howAreYouFeeling,
                        transitionNamespace: animation,
                        onSelectDone: { feeling in
                if isMeditationCompleted {
                    afterFeeling = feeling
                    reviewCompleted.toggle()
                } else {
                    currentFeeling = feeling
                    withAnimation(.interpolatingSpring(stiffness: 100, damping: 13)) {
                        isFeelingViewVisible.toggle()
                    }
                }
            })
            .sheet(isPresented: $reviewCompleted) {
                ShareView(intend: $currentIntend, fromFeeling: $currentFeeling, toFeeling: $afterFeeling)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
