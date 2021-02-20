//
//  MoodView.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 20/02/2021.
//

import SwiftUI

struct MoodView: View {
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .padding(.all, 16)
            .aspectRatio(contentMode: .fit)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.orange)
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView()
    }
}
