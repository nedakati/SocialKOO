//
//  FeelingView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 20/02/2021.
//

import SwiftUI

enum Strings {
    static let howAreYouFeeling = "How are you \n feeling?"
    static let swipeUpAndDown = "Swipe up and down to select \n your mood."
}

enum MoodViewState {
    case sob
    case confused
    case neutral
    case grin
    case star
}

struct FeelingView: View {
    @State private var currentStateIndex: Int = 2
    private let states: [MoodViewState] = [.sob, .confused, .neutral, .grin, .star]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), states[currentStateIndex].color]), startPoint: .top, endPoint: .bottom)
                .transition(.opacity)

            VStack {
                Text(Strings.howAreYouFeeling)
                    .font(.system(size: 34, weight: .bold))
                    .multilineTextAlignment(.center)

                Image(states[currentStateIndex].image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Text(Strings.swipeUpAndDown)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)
            }
            .transition(.opacity)
            .padding(.horizontal, 24)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.height < 0 {
                            withAnimation(.easeIn(duration: 0.7)) {
                                currentStateIndex = min(currentStateIndex + 1, states.count - 1)
                            }
                        }

                        if value.translation.height > 0 {
                            withAnimation(.easeIn(duration: 0.7)) {
                                currentStateIndex = max(currentStateIndex - 1, 0)
                            }
                        }
                    }
            )
        }
        .ignoresSafeArea(.all)
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView()
    }
}

private extension MoodViewState {
    var image: String {
        switch self {
        case .sob: return "Moods/sob"
        case .confused: return "Moods/confused"
        case .neutral: return "Moods/neutral"
        case .grin: return "Moods/grin"
        case .star: return "Moods/star"
        }
    }

    var color: Color {
        switch self {
        case .sob: return Color(#colorLiteral(red: 0.5951487422, green: 0.5375294685, blue: 0.437197268, alpha: 1))
        case .confused: return Color(#colorLiteral(red: 0.8427037597, green: 0.7486416698, blue: 0.5794628859, alpha: 1))
        case .neutral: return Color(#colorLiteral(red: 0.9566310048, green: 0.8053438663, blue: 0.5484393239, alpha: 1))
        case .grin: return Color(#colorLiteral(red: 0.9427179694, green: 0.7272000909, blue: 0.5409936905, alpha: 1))
        case .star: return Color(#colorLiteral(red: 0.9416705966, green: 0.6363645792, blue: 0.5416007042, alpha: 1))
        }
    }
}
