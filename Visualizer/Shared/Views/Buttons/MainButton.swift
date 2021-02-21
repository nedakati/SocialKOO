//
//  MainButton.swift
//  Visualizer
//
//  Created by Katalin Neda on 20/02/2021.
//

import SwiftUI

struct MainButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(Color.white)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Color.black)
                .cornerRadius(24)
                .shadow(color: Color.black.opacity(0.5), radius: 24, x: 0, y: 16)
        }
    }
}
