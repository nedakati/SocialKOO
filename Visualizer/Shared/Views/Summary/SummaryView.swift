//
//  SummaryView.swift
//  Visualizer (iOS)
//
//  Created by Katalin Neda on 21/02/2021.
//

import SwiftUI

struct SummaryView: View {
    
    @Environment(\.presentationMode) private var presentationMode

    var mood: Intend

    init(mood: Intend) {
        self.mood = mood
    
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: mood.gradients), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    ZStack {
                        Color(.white)
                            .opacity(0.5)
                            .cornerRadius(40)
                        VStack {
                            Text(Strings.moodBoosting)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Text("For x mins")
                                .font(.headline)
                                .foregroundColor(.black)
                            HStack {
                                    Image(Feeling.confused.image)
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(1, contentMode: .fit)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .bold))
                                    Image(Feeling.star.image)
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(1, contentMode: .fit)
                            }
                            NavigationLink(destination: ShareView(intend: mood)) {
                                Text("Share")
                                    .font(.system(size: 20, weight: .regular))
                                    .frame(width: 100, height: 48)
                                    .background(Color.black)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(24)
                                    .shadow(color: Color.black.opacity(0.5), radius: 24, x: 0, y: 16)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                    .cornerRadius(10)
                    .aspectRatio(1, contentMode: .fit)
                }
            }
            .navigationBarTitle(Strings.summary, displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .regular))
                                    }
            )
        }
    }
}
