//
//  Polygon.swift
//  Visualizer
//
//  Created by Katalin Neda on 21/02/2021.
//

import SwiftUI

struct Polygon: View {
    
    var width: CGFloat
    var height: CGFloat
    var speed: TimeInterval
    
    @State private var sides = 3

    private var timer = Timer.publish(every: 2, on: .main, in: .default).autoconnect()

    init(width: CGFloat, height: CGFloat, speed: TimeInterval) {
        self.width = width
        self.height = height
        self.speed = speed

        timer = Timer.publish(every: speed, on: .main, in: .default).autoconnect()
    }
    
    var body: some View {
        PolygonShape(sides: sides)
            .cornerRadius(20)
            .opacity(0.3)
            .frame(width: width, height: height)
            .animation(.easeInOut(duration: speed))
            .animation(.easeIn)
            .onReceive(timer) { _ in
                sides = Int.random(in: 5...15)
            }
    }
}
