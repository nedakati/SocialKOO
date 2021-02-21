//
//  Mood.swift
//  Visualizer
//
//  Created by Katalin Neda on 19/02/2021.
//

import SwiftUI

extension Intend {

    var mainColor: Color {
        switch self {
        case .chillOut: return Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        case .moodBoost: return Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        case .stopWorrying: return Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        case .mindDistraction: return Color.random
        }
    }
    
    var gradients: [Color] {
        switch self {
        case .chillOut: return [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        case .moodBoost: return [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        case .stopWorrying: return [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        case .mindDistraction: return [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        }
    }
    
    var defaultSpeed: TimeInterval {
        switch self {
        case .chillOut: return 4
        case .moodBoost: return 4
        case .stopWorrying: return 4
        case .mindDistraction: return 0.8
        }
    }
    
    var minMaxSpeed: TimeInterval {
        switch self {
        case .chillOut: return 4
        case .moodBoost: return 0.5
        case .stopWorrying: return 0.5
        case .mindDistraction: return TimeInterval.random(in: 0.1...0.5)
        }
    }
    
    var timeToStartChaingingSpeed: Int {
        switch self {
        case .chillOut: return 10
        case .moodBoost: return 10
        case .stopWorrying: return 10
        case .mindDistraction: return 30
        }
    }
    
    var layers: Int {
        switch self {
        case .chillOut: return 10
        case .moodBoost: return 40
        case .stopWorrying: return 20
        case .mindDistraction: return 40
        }
    }
    
    var polygonBaseSize: Int {
        switch self {
        case .chillOut: return 50
        case .moodBoost: return 10
        case .stopWorrying: return 20
        case .mindDistraction: return 10
        }
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
