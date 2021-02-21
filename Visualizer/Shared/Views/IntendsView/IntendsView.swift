//
//  IntendsView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 21/02/2021.
//

import SwiftUI

struct IntendsView: View {
    @Binding var feeling: Feeling

    let transitionNamespace: Namespace.ID

    var onSelectBack: (() -> Void)
    var onSelectIntend: ((Intend) -> Void)

    private let intends: [Intend] = [.chillOut, .moodBoost, .stopWorrying, .mindDistraction]

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack {
                    Image(feeling.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "ImageAnimation", in: transitionNamespace)
                        .frame(width: 160, height: 160)
                        .padding(.top, 16)
                        .onTapGesture {
                            onSelectBack()
                        }

                    Text(Strings.whatDoYouWantToAchieve)
                        .font(.system(size: 34, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 32)

                    VStack(spacing: 0) {
                        ForEach(intends, id: \.self) { item in
                            StatedButton(action: {
                                onSelectIntend(item)
                            }) {
                                ZStack {
                                    Text(item.text)
                                        .font(.system(size: 21, weight: .bold))
                                        .foregroundColor(Color.primary)
                                        .frame(height: 104)
                                        .frame(maxWidth: .infinity)
                                        .background(Color("IntendColor"))
                                        .cornerRadius(24)

                                    HStack {
                                        Image(item.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 48, height: 48)
                                            .padding(.leading, 16)

                                        Spacer()
                                    }
                                }
                            }
                            .padding(.bottom, 16)
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                }
            }

            Button(action: {
                onSelectBack()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color.primary)
                        .padding(.leading, 16)
                        .frame(width: 44, height: 44)

                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

// MARK: - Intend

extension Intend {
    var imageName: String {
        switch self {
        case .chillOut: return "Moods/chillOut"
        case .moodBoost: return "Moods/moodBoost"
        case .stopWorrying: return "Moods/stopWorrying"
        case .mindDistraction: return "Moods/mindDistraction"
        }
    }

    var text: String {
        switch self {
        case .chillOut: return Strings.chillOut
        case .moodBoost: return Strings.moodBoost
        case .stopWorrying: return Strings.stopWorrying
        case .mindDistraction: return Strings.relievePain
        }
    }
}

struct IntendsView_Previews: PreviewProvider {
    private struct TestView: View {
        @Namespace private var animation

        var body: some View {
            IntendsView(feeling: .constant(.grin), transitionNamespace: animation, onSelectBack: {}, onSelectIntend: { _ in })
        }
    }

    static var previews: some View {
        TestView()
    }
}
