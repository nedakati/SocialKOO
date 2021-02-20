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
            .stroke(Color.white, lineWidth: 3)
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
                ZStack {
                    ForEach(1 ..< 20) { number in
                        Polygon(width: CGFloat(20 * number), height: CGFloat(20 * number), mood: mood)
                            .scaleEffect(scale)
                    }
                }
                Spacer()
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
