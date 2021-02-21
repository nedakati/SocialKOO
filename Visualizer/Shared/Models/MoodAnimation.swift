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
        case .chillOut: return Color(#colorLiteral(red: 1, green: 0.3921568627, blue: 0.2470588235, alpha: 1))
        case .moodBoost: return Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        case .stopWorrying: return Color(#colorLiteral(red: 1, green: 1, blue: 0.9490196078, alpha: 1))
        case .mindDistraction: return Color.random
        }
    }
    
    var gradients: [Color] {
        switch self {
        case .chillOut: return [Color(#colorLiteral(red: 0.6980392157, green: 0.7960784314, blue: 0.6078431373, alpha: 1)), Color(#colorLiteral(red: 0.6980392157, green: 0.7960784314, blue: 0.6078431373, alpha: 1)), Color(#colorLiteral(red: 0.3568627451, green: 0.5882352941, blue: 0.5960784314, alpha: 1))]
        case .moodBoost: return [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        case .stopWorrying: return [Color(#colorLiteral(red: 1, green: 0.8274509804, blue: 0.768627451, alpha: 1)), Color(#colorLiteral(red: 0.9215686275, green: 0.7529411765, blue: 0.4705882353, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]
        case .mindDistraction: return [Color(#colorLiteral(red: 0, green: 1, blue: 0.9803921569, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.1892502156, blue: 0.3529411852, alpha: 1))]
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
    
    var songTitle: String {
        switch self {
        case .chillOut: return "chill"
        case .moodBoost: return "heart"
        case .stopWorrying: return "calm"
        case .mindDistraction: return "techno"
        }
    }
    
    var songType: String {
        switch self {
        case .chillOut: return "mp3"
        case .moodBoost: return "wav"
        case .stopWorrying: return "wav"
        case .mindDistraction: return "wav"
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
