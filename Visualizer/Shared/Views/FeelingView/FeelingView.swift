//
//  FeelingView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 20/02/2021.
//

import SwiftUI

struct FeelingView: View {

    @State private var currentStateIndex: Int
    private let states: [Feeling] = [.sob, .confused, .neutral, .grin, .star]

    @State private var isFirstLayer = true

    private let transitionNamespace: Namespace.ID
    private let onSelectDone: ((Feeling) -> Void)?

    init(with feeling: Feeling, transitionNamespace: Namespace.ID, onSelectDone: ((Feeling) -> Void)?) {
        self.transitionNamespace = transitionNamespace
        self.onSelectDone = onSelectDone
        
        let stateIndex = states.firstIndex { $0 == feeling } ?? 2
        _currentStateIndex = State(initialValue: stateIndex)
        _gradientFirstLayer = State(initialValue: feeling.gradientColors)
        _gradientSecondLayer = State(initialValue: feeling.gradientColors)

        _imageFirstLayer = State(initialValue: Image(feeling.image))
        _imageSecondLayer = State(initialValue: Image(feeling.image))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: gradientSecondLayer), startPoint: .top, endPoint: .bottom)
                .opacity(self.isFirstLayer ? 0 : 1)
                .animation(.spring())

            LinearGradient(gradient: Gradient(colors: gradientFirstLayer), startPoint: .top, endPoint: .bottom)
                .opacity(self.isFirstLayer ? 1 : 0)
                .animation(.spring())

            VStack {
                Spacer()

                Text(Strings.howAreYouFeeling)
                    .font(.system(size: 34, weight: .bold))
                    .multilineTextAlignment(.center)

                ZStack {
                    imageSecondLayer
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(self.isFirstLayer ? 0 : 1)
                        .animation(.easeIn(duration: 0.33))
                    imageFirstLayer
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(self.isFirstLayer ? 1 : 0)
                        .animation(.easeIn(duration: 0.33))
                }
                .matchedGeometryEffect(id: "ImageAnimation", in: transitionNamespace)

                Text(Strings.swipeUpAndDown)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)

                Spacer()
                
                MainButton(title: Strings.done) {
                    onSelectDone?(states[currentStateIndex])
                }
                .padding(32)
            }
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
                            currentStateIndex = newStateIndex
                            isFirstLayer.toggle()
                            setGradient(gradient: states[currentStateIndex].gradientColors)
                            setImage(image: Image(states[currentStateIndex].image))
                        }
                    }
                }
        )
        .ignoresSafeArea(.all)
    }

    // MARK: - Gradient hell

    @State private var gradientFirstLayer: [Color]
    @State private var gradientSecondLayer: [Color]

    private func setGradient(gradient: [Color]) {
        if isFirstLayer {
            gradientFirstLayer = gradient
        } else {
            gradientSecondLayer = gradient
        }
    }

    // MARK: - Image hell

    @State private var imageFirstLayer: Image
    @State private var imageSecondLayer: Image

    private func setImage(image: Image) {
        if isFirstLayer {
            imageFirstLayer = image
        } else {
            imageSecondLayer = image
        }
    }
}

extension Feeling {
    var image: String {
        switch self {
        case .sob: return "Moods/sob"
        case .confused: return "Moods/confused"
        case .neutral: return "Moods/neutral"
        case .grin: return "Moods/grin"
        case .star: return "Moods/star"
        }
    }
    var gradientColors: [Color] {
        switch self {
        case .sob: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.5951487422, green: 0.5375294685, blue: 0.437197268, alpha: 1))]
        case .confused: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.8427037597, green: 0.7486416698, blue: 0.5794628859, alpha: 1))]
        case .neutral: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.877808094, green: 0.7393150926, blue: 0.511480689, alpha: 1))]
        case .grin: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.9316776395, green: 0.715811193, blue: 0.5352671146, alpha: 1))]
        case .star: return [Color(#colorLiteral(red: 0.9959074855, green: 0.9962145686, blue: 0.9916471839, alpha: 1)), Color(#colorLiteral(red: 0.9801376462, green: 0.6582708359, blue: 0.5666258931, alpha: 1))]
        }
    }
}
