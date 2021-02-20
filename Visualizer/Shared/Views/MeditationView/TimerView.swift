//
//  TimerView.swift
//  Visualizer
//
//  Created by Katalin Neda on 19/02/2021.
//

import SwiftUI

struct TimerView: View {
    
    var targetMinutes: Int

    @State var timeRemaining: Int = 60
    
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
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        seconds -= 1
                        
                        if seconds == -1 {
                            minutes -= 1
                            seconds = 59
                        }
                    }
                }
                .onAppear {
                    self.timeRemaining = targetMinutes * 60
                    self.minutes = targetMinutes
                }
        }
    }
    
    private func formarSeconds(_ seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }

}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(targetMinutes: 5)
    }
}
