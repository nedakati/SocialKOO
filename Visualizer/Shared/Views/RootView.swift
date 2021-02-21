//
//  RootView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 20/02/2021.
//

import SwiftUI

struct RootView: View {
    
    @State private var isMeditationViewVisible = false
    @State private var isReviewViewVisible = false
    @State private var reviewCompleted = false
    @State private var isFeelingViewVisible = false
    @State private var currentFeeling: Feeling = .neutral
    @State private var afterFeeling: Feeling = .neutral
    @State private var currentIntend: Intend = .chillOut

    @Namespace private var animation
    
    @State private var time: Int = 0

    var body: some View {
        if isMeditationViewVisible {
            MeditationView(intend: currentIntend) { time in
                self.time = time
        
                isFeelingViewVisible.toggle()
                isMeditationViewVisible.toggle()
                isReviewViewVisible.toggle()
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
        } else if isReviewViewVisible {
            FeelingView(with: currentFeeling,
                        title: Strings.howAreYouFeelingNow,
                        transitionNamespace: animation,
                        onSelectDone: { feeling in
                            afterFeeling = feeling
                            reviewCompleted.toggle()
                        })
                .sheet(isPresented: $reviewCompleted) {
                    ShareView(intend: $currentIntend, fromFeeling: $currentFeeling, toFeeling: $afterFeeling, time: $time, onDone: {
                        reset()
                    })
                }
        } else {
            FeelingView(with: currentFeeling,
                        title: Strings.howAreYouFeeling,
                        transitionNamespace: animation,
                        onSelectDone: { feeling in
                            currentFeeling = feeling
                            withAnimation(.interpolatingSpring(stiffness: 100, damping: 13)) {
                                isFeelingViewVisible.toggle()
                            }
                        })
        }
    }

    private func reset() {
        isReviewViewVisible = false
        isMeditationViewVisible = false
        reviewCompleted = false
        isFeelingViewVisible = false
        currentFeeling = .neutral
        afterFeeling = .neutral
        currentIntend = .chillOut
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
