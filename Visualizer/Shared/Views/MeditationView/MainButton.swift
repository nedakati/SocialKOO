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
        Button(title, action: action)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 48)
            .background(Color.primary)
            .foregroundColor(Color.systemBackground)
            .cornerRadius(24)
            .padding(24)
            .shadow(color: Color.black.opacity(0.5), radius: 24, x: 0, y: 16)
            .padding(.horizontal, 24)
    }
}
