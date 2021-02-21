//
//  ShareView.swift
//  Visualizer (iOS)
//
//  Created by Katalin Neda on 21/02/2021.
//

import SwiftUI

struct ResultView: View {

    @Binding var intend: Intend
    @Binding var fromFeeling: Feeling
    @Binding var toFeeling: Feeling
    @Binding var timeText: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: intend.gradients), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        ZStack {
            Color(.white)
                .opacity(0.5)
                .cornerRadius(40)
            VStack {
                Text(Strings.iHaveTried)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                Text(Strings.moodBoosting)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text(timeText)
                    .font(.headline)
                    .foregroundColor(.black)
                HStack {
                        Image(fromFeeling.image)
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(1, contentMode: .fit)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .bold))
                        Image(toFeeling.image)
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(1, contentMode: .fit)
                }
                Text(Strings.tryItYourself)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .cornerRadius(10)
        .aspectRatio(1, contentMode: .fit)
    }
    }
}

struct ShareView: View {

    @Binding private var intend: Intend
    @Binding private var fromFeeling: Feeling
    @Binding private var toFeeling: Feeling
    @Binding private var time: Int

    @State private var geometry: GeometryProxy?
    @State private var showAlert = false

    @Environment(\.presentationMode) private var presentationMode

    @State private var timeText: String = ""
    
    init(intend: Binding<Intend>, fromFeeling: Binding<Feeling>, toFeeling: Binding<Feeling>, time: Binding<Int>) {
        _intend = intend
        _fromFeeling = fromFeeling
        _toFeeling = toFeeling
        _time = time
            
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                VStack {
                    GeometryReader { geometry in
                        ResultView(intend: $intend, fromFeeling: $fromFeeling, toFeeling: $toFeeling, timeText: $timeText)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.clear, lineWidth: 5)
                            )
                        .onAppear {
                            self.geometry = geometry
                        }
                    }
                    .padding()
                    .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 16)
                    Spacer()
                    MainButton(title: Strings.saveToPhotoGallery) {
                        if let geometry = geometry {
                            let screenshot = ResultView(intend: $intend, fromFeeling: $fromFeeling, toFeeling: $toFeeling, timeText: $timeText).takeScreenshot(origin: geometry.frame(in: .local).origin, size: geometry.size)
                            
                            let imageSaver = ImageSaver()

                            imageSaver.successHandler = {
                                showAlert = true
                            }

                            imageSaver.errorHandler = {
                                print("Oops: \($0.localizedDescription)")
                            }

                            imageSaver.writeToPhotoAlbum(image: screenshot)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .alert(isPresented: $showAlert) { () -> Alert in
                        Alert(title: Text(Strings.imageSaved), message: Text(""), dismissButton: .cancel())
                    }
                }
            }
            .onAppear {
                let minutes = (time % 3600) / 60
                let seconds = (time % 3600) % 60
                
                if minutes > 0 {
                    timeText = "for \(minutes)m \(seconds)s"
                } else {
                    timeText = "for \(seconds)s"
                }
            }
            .navigationBarTitle(Strings.overview, displayMode: .inline)
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