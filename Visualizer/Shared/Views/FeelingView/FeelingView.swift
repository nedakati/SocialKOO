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

    @State private var titleText: String

    init(with feeling: Feeling, title: String, transitionNamespace: Namespace.ID, onSelectDone: ((Feeling) -> Void)?) {
        self.transitionNamespace = transitionNamespace
        self.onSelectDone = onSelectDone

        _titleText = State(initialValue: title)
        
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

                Text(titleText)
                    .font(.system(size: 34, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)

                ZStack {
                    imageSecondLayer
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(self.isFirstLayer ? 0 : 1)
                        .animation(.linear(duration: 0.33))
                    imageFirstLayer
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(self.isFirstLayer ? 1 : 0)
                        .animation(.linear(duration: 0.33))
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
                    if value.translation.height < -50 {
                        newStateIndex = min(currentStateIndex + 1, states.count - 1)
                    }
                    if value.translation.height > 50 {
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
        case .sob: return [Color("BackgroundColor"), Color("SobColorBottom")]
        case .confused: return [Color("BackgroundColor"), Color("ConfusedColorBottom")]
        case .neutral: return [Color("BackgroundColor"), Color("NeutralColorBottom")]
        case .grin: return [Color("BackgroundColor"), Color("GrinColorBottom")]
        case .star: return [Color("BackgroundColor"), Color("StarColorBottom")]
        }
    }
}

// MARK: - Preview

struct FeelingView_Previews: PreviewProvider {
    private struct TestView: View {
        @Namespace private var animation

        var body: some View {
            Group {
                FeelingView(with: .confused, title: Strings.howAreYouFeeling, transitionNamespace: animation, onSelectDone: { _ in })

                FeelingView(with: .confused, title: Strings.howAreYouFeeling, transitionNamespace: animation, onSelectDone: { _ in })
                    .preferredColorScheme(.dark)
            }
        }
    }

    static var previews: some View {
        TestView()
    }
}
