//
//  Mood.swift
//  Visualizer
//
//  Created by Katalin Neda on 19/02/2021.
//

import SwiftUI

enum MoodAnimation {
    case chillOut
    case moodBoost
    case worrying
    case mindDistraction
}

extension MoodAnimation {
    var mainColor: Color {
        switch self {
        case .chillOut: return .orange
        case .moodBoost: return .green
        case .worrying: return .purple
        case .mindDistraction: return .blue
        }
    }
    
    var gradients: [Color] {
        switch self {
        case .chillOut: return [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        case .moodBoost: return [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        case .worrying: return [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        case .mindDistraction: return [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        }
    }
    
    var defaultSpeed: TimeInterval { 5 }
    
    var minMaxSpeed: TimeInterval {
        switch self {
        case .chillOut: return 3
        case .moodBoost: return 4
        case .worrying: return 5
        case .mindDistraction: return 5
        }
    }
    
    var timeToStartChaingingSpeed: Int {
        switch self {
        case .chillOut: return 10
        case .moodBoost: return 10
        case .worrying: return 10
        case .mindDistraction: return 10
        }
    }
}
