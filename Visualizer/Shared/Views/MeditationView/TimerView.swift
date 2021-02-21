//
//  TimerView.swift
//  Visualizer
//
//  Created by Katalin Neda on 19/02/2021.
//

import SwiftUI

struct TimerView: View {

    private let animation: Intend
    private let changeSpeed: () -> Void

    @Binding var time: Int
    
    @State private var timeRemaining: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    
    init(time: Binding<Int>, animation: Intend, changeSpeed: @escaping () -> Void) {
        _time = time
        self.animation = animation
        self.changeSpeed = changeSpeed
    }
    
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(minutes):\(formarSeconds(seconds))")
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .font(.title2)
                .onReceive(timer) { _ in
                    timeRemaining += 1
                    seconds += 1
        
                    time = timeRemaining
                    if seconds == 60 {
                        minutes += 1
                        seconds = 0
                    }
                    
                    if timeRemaining % animation.timeToStartChaingingSpeed == 0 {
                        changeSpeed()
                    }
                }
        }
    }
    
    private func formarSeconds(_ seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
}
