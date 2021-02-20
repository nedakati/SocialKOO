//
//  FeelingView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 20/02/2021.
//

import SwiftUI

//private struct FadeAnimationView: View {
//    var body: some View {
//        ZStack {
//
//        }
//    }
//}

struct FeelingView: View {
    @State private var currentStateIndex: Int = 2
    private let states: [Feeling] = [.sob, .confused, .neutral, .grin, .star]

    @State private var firstGradient = Gradient(colors: Feeling.neutral.gradient)
    @State private var secondGradient = Gradient(colors: Feeling.neutral.gradient)

    @State private var isFirstOn = true

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: Feeling.neutral.gradient), startPoint: .top, endPoint: .bottom)
                .animation(.spring())
                .opacity(isFirstOn ? 1 : 0)

            LinearGradient(gradient: Gradient(colors: Feeling.grin.gradient), startPoint: .top, endPoint: .bottom)
                .animation(.spring())
                .opacity(isFirstOn ? 0 : 1)

            VStack {
                Text(Strings.howAreYouFeeling)
                    .font(.system(size: 34, weight: .bold))
                    .multilineTextAlignment(.center)

                ZStack {
                    Image(Feeling.neutral.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(isFirstOn ? 1 : 0)
                        .animation(.easeIn(duration: 0.33))

                    Image(Feeling.grin.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(isFirstOn ? 0 : 1)
                        .animation(.easeIn(duration: 0.33))
                }

                Text(Strings.swipeUpAndDown)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 24)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    var newStateIndex = currentStateIndex
                    if value.translation.height < 0 {
                        newStateIndex = min(currentStateIndex + 1, states.count - 1)
                    }

                    if value.translation.height > 0 {
                        newStateIndex = max(currentStateIndex - 1, 0)
                    }

                    if newStateIndex != currentStateIndex {
                        withAnimation(.linear(duration: 1)) {
                            isFirstOn.toggle()
                            currentStateIndex = newStateIndex
                        }
                    }
                }
        )
        .ignoresSafeArea(.all)
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView()
    }
}

private extension Feeling {
    var image: String {
        switch self {
        case .sob: return "Moods/sob"
        case .confused: return "Moods/confused"
        case .neutral: return "Moods/neutral"
        case .grin: return "Moods/grin"
        case .star: return "Moods/star"
        }
    }

    var gradient: [Color] {
        switch self {
        case .sob: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.5951487422, green: 0.5375294685, blue: 0.437197268, alpha: 1))]
        case .confused: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.8427037597, green: 0.7486416698, blue: 0.5794628859, alpha: 1))]
        case .neutral: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.877808094, green: 0.7393150926, blue: 0.511480689, alpha: 1))]
        case .grin: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.9316776395, green: 0.715811193, blue: 0.5352671146, alpha: 1))]
        case .star: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.9801376462, green: 0.6582708359, blue: 0.5666258931, alpha: 1))]
        }
    }
}
