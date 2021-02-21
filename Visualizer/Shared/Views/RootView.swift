//
//  RootView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 20/02/2021.
//

import SwiftUI

struct RootView: View {
    
    @State private var isMeditationViewVisible = false
    @State private var showingDetail = false
    @State private var isFeelingViewVisible = false
    @State private var currentFeeling: Feeling = .neutral

    @Namespace private var animation

    var body: some View {
        if isMeditationViewVisible {
            MeditationView(mood: .chillOut) {
                showingDetail.toggle()
            }
            .sheet(isPresented: $showingDetail) {
                ShareView(mood: .chillOut)
            }
            .transition(.opacity)
        } else if isFeelingViewVisible {
            IntendsView(feeling: $currentFeeling, transitionNamespace: animation, onSelectBack: {
                withAnimation(.linear(duration: 0.33)) {
                    isFeelingViewVisible.toggle()
                }
            })
                .onTapGesture {
                    isMeditationViewVisible.toggle()
                }
        } else {
            FeelingView(with: currentFeeling, transitionNamespace: animation, onSelectDone: { feeling in
                currentFeeling = feeling
                withAnimation(.interpolatingSpring(stiffness: 100, damping: 13)) {
                    isFeelingViewVisible.toggle()
                }
            })
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
