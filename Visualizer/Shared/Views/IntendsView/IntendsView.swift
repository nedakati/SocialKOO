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

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Image(feeling.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "ImageAnimation", in: transitionNamespace)
                    .frame(width: 160, height: 160)
                    .padding(.top, 16)

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

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

struct IntendsView_Previews: PreviewProvider {
    private struct TestView: View {
        @Namespace private var animation

        var body: some View {
            IntendsView(feeling: .constant(.grin), transitionNamespace: animation, onSelectBack: {})
        }
    }

    static var previews: some View {
        TestView()
    }
}
