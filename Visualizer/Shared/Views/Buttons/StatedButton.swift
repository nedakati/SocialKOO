//
//  StatedButton.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 21/02/2021.
//

import SwiftUI

// from: https://stackoverflow.com/questions/57617775/swiftui-button-selection
struct SelectableButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 104)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(configuration.isPressed ? Color.primary : Color.clear, lineWidth: 2)
            )
    }
}

struct StatedButton<Label>: View where Label: View {

    private let action: (() -> ())?
    private let label: (() -> Label)?

    @State var buttonStyle = SelectableButtonStyle()

    init(action: (() -> ())? = nil, label: (() -> Label)? = nil) {
        self.action = action
        self.label = label
    }

    var body: some View {
        Button(action: {
            self.action?()
        }) {
            label?()
        }
        .buttonStyle(buttonStyle)
    }
}
