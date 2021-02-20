//
//  MeditationView.swift
//  Visualizer
//
//  Created by Katalin Neda on 19/02/2021.
//

import SwiftUI
import AVFoundation

struct Polygon: View {
    
    var width: CGFloat
    var height: CGFloat
    
    var mood: Mood
    
    @State private var sides = 3

    private var timer = Timer.publish(every: 2, on: .main, in: .default).autoconnect()

    init(width: CGFloat, height: CGFloat, mood: Mood) {
        self.width = width
        self.height = height
        self.mood = mood
        
        timer = Timer.publish(every: mood.speed, on: .main, in: .default).autoconnect()
    }
    
    var body: some View {
        PolygonShape(sides: sides)
            .foregroundColor(Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
            .cornerRadius(20)
            .opacity(0.3)
            .frame(width: width, height: height)
            .animation(.easeInOut(duration: mood.speed))
            .animation(.easeIn)
            .onReceive(timer) { _ in
                sides = Int.random(in: 5...15)
            }
    }
}

struct MeditationView: View {
    
    var mood: Mood
    
    @State private var scale: CGFloat = 1
    @State private var scalePolygon: CGFloat = 1
    @State private var offset = CGSize.zero

    private var audioPlayer: AVAudioPlayer?
    
    init(mood: Mood) {
        self.mood = mood
        if let path = Bundle.main.path(forResource: "music_zapsplat_among_the_stars", ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            } catch {
                print("error")
            }
        }
    }

    var body: some View {
        ZStack {
            GradientBackgroundView(colors: mood.gradients)
                .ignoresSafeArea()
            VStack {
                Spacer()
                ZStack {
                    ForEach(1 ..< 10) { number in
                        Polygon(width: CGFloat(50 * number), height: CGFloat(50 * number), mood: mood)
                            .scaleEffect(scale)
                            .rotation3DEffect(.degrees(scale == 1 ? 180 : 45), axis: (x: 0, y: 0, z: 1))
                    }
                }
                .offset(x: offset.width, y: offset.height)
                .scaleEffect(scalePolygon)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
                                self.offset = gesture.translation
                                self.scalePolygon = 2
                            }
                        }
                        .onEnded { gesture in
                            withAnimation(.interpolatingSpring(stiffness: 300, damping: 10)) {
                                self.offset = .zero
                                self.scalePolygon = 1
                            }
                        }
                )
                if scale == 1 {
                    Text("Breathe in")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .animation(.easeInOut(duration: mood.speed))
                } else {
                    Text("Breathe out")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .animation(.easeInOut(duration: mood.speed))
                }
                TimerView(targetMinutes: 5)
            }
        }
        .onAppear {
            playSound()

            let animation = Animation.easeInOut(duration: mood.speed).repeatForever(autoreverses: true)
            withAnimation(animation) {
                scale = 0.5
            }
        }
    }
    
    func playSound() {
        audioPlayer?.play()
        audioPlayer?.numberOfLoops = 3

    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView(mood: .sad)
    }
}
