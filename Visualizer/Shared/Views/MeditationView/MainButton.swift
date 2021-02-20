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
            .background(Color(UIColor.systemBackground))
            .foregroundColor(Color(UIColor.label))
            .cornerRadius(24)
            .padding(20)
            .shadow(color: Color.black.opacity(0.5), radius: 24, x: 0, y: 16)
            .padding([.leading, .trailing], 24)
    }
}
