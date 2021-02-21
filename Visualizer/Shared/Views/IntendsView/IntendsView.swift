//
//  IntendsView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 21/02/2021.
//

import SwiftUI

struct IntendsView: View {
    let feeling: Feeling

    @Namespace private var imageAnimation

    var body: some View {
        VStack {
            Image(feeling.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "ImageAnimation", in: imageAnimation)

            Spacer()
        }
    }
}

struct IntendsView_Previews: PreviewProvider {
    static var previews: some View {
        IntendsView(feeling: .grin)
    }
}
