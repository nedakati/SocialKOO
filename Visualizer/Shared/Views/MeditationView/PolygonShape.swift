//
//  PolygonShape.swift
//  Visualizer
//
//  Created by Katalin Neda on 19/02/2021.
//

import SwiftUI

struct PolygonShape: Shape {
    
    var sides: Double
    
    // MARK: - Override this computed property, since Shape is conforms to Animatable
    var animatableData: Double {
        get { return sides }
        set { sides = newValue }
    }
    
    init(sides: Int) {
        self.sides = Double(sides)
    }
        
    func path(in rect: CGRect) -> Path {

        let hypotenuse = Double(min(rect.size.width, rect.size.height)) / 2.0
        let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
            
        var path = Path()
        
        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
                    
        for i in 0..<Int(sides) + extra {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180

            // Calculate the next vertex position
            let point = CGPoint(x: center.x + CGFloat(cos(angle) * hypotenuse), y: center.y + CGFloat(sin(angle) * hypotenuse))
                
            if i == 0 {
                // First  vertex: let's move here
                path.move(to: point)
            } else {
                // Draw line to the next vertex:
                path.addLine(to: point)
            }
        }
            
        path.closeSubpath()
            
        return path
    }
}

struct PolygonShape_Previews: PreviewProvider {
    static var previews: some View {
        PolygonShape(sides: 3)
    }
}
