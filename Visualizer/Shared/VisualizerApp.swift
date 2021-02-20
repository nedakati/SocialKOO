//
//  VisualizerApp.swift
//  Shared
//
//  Created by Katalin Neda on 19/02/2021.
//

import SwiftUI

@main
struct VisualizerApp: App {
    var body: some Scene {
        WindowGroup {
            MeditationView(mood: .depressed)
        }
    }
}
