//
//  Extesions.swift
//  Visualizer
//
//  Created by Orsolya Bardi on 21/02/2021.
//

import SwiftUI

public extension Color {
    static let systemBackground = Color(UIColor.systemBackground)
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
