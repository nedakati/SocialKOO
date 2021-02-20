//
//  TimerView.swift
//  Visualizer
//
//  Created by Katalin Neda on 19/02/2021.
//

import SwiftUI

struct TimerView: View {

    let animation: MoodAnimation
    let onReachMinutes: () -> Void
    
    @State var timeRemaining: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(minutes):\(formarSeconds(seconds))")
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(.largeTitle)
                .onReceive(timer) { _ in
                    timeRemaining += 1
                    seconds += 1
                        
                    if seconds == 60 {
                        minutes += 1
                        seconds = 0
                    }
                    
                    if timeRemaining % animation.timeToStartChaingingSpeed == 0 {
                        onReachMinutes()
                    }
                }
        }
    }
    
    private func formarSeconds(_ seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
}
