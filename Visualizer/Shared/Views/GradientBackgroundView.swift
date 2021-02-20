//
//  GradientBackgroundView.swift
//  Visualizer
//
//  Created by Katalin Neda on 19/02/2021.
//

import SwiftUI

struct GradientBackgroundView: View {
    
    let  colors: [Color]
    
    @State var startPoint = UnitPoint(x: 0, y: -2)
    @State var endPoint = UnitPoint(x: 4, y: 0)
    
    private let timer = Timer.publish(every: 0.5, on: .main, in: .default).autoconnect()
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
            .animation(Animation.easeInOut(duration: 6).repeatForever())
            .onReceive(timer, perform: { _ in
                self.startPoint = UnitPoint(x: 4, y: 0)
                self.endPoint = UnitPoint(x: 0, y: 2)
                self.startPoint = UnitPoint(x: -4, y: 20)
                self.startPoint = UnitPoint(x: 4, y: 0)
            })
    }
}
