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
    var speed: TimeInterval
    
    @State private var sides = 3

    private var timer = Timer.publish(every: 2, on: .main, in: .default).autoconnect()

    init(width: CGFloat, height: CGFloat, speed: TimeInterval) {
        self.width = width
        self.height = height
        self.speed = speed

        timer = Timer.publish(every: speed, on: .main, in: .default).autoconnect()
    }
    
    var body: some View {
        PolygonShape(sides: sides)
            .foregroundColor(Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
            .cornerRadius(20)
            .opacity(0.3)
            .frame(width: width, height: height)
            .animation(.easeInOut(duration: speed))
            .animation(.easeIn)
            .onReceive(timer) { _ in
                sides = Int.random(in: 5...15)
            }
    }
}

struct MeditationView: View {
    
    var mood: MoodAnimation
    
    @State private var scale: CGFloat = 1
    @State private var scalePolygon: CGFloat = 1
    @State private var offset = CGSize.zero
    
    @State private var speed: TimeInterval = 0

    private var audioPlayer: AVAudioPlayer?
    
    init(mood: MoodAnimation) {
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
            VStack(alignment: .center) {
                HStack {
                    TimerView(animation: mood) {
                        speed -= 0.5
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 24, leading: 48, bottom: 24, trailing: 24))
                ZStack {
                    ForEach(1 ..< 10) { number in
                        Polygon(width: CGFloat(50 * number), height: CGFloat(50 * number), speed: speed)
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
                                self.scalePolygon = 0.3
                            }
                        }
                        .onEnded { gesture in
                            withAnimation(.interpolatingSpring(stiffness: 300, damping: 10)) {
                                self.offset = .zero
                                self.scalePolygon = 1
                            }
                        }
                )
                Spacer()
                if scale == 1 {
                    Text("Breathe in")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .animation(.easeInOut(duration: mood.defaultSpeed))
                } else {
                    Text("Breathe out")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .animation(.easeInOut(duration: mood.defaultSpeed))
                }
            }
            Spacer()
        }
        .onAppear {
            playSound()
            speed = mood.defaultSpeed
            let animation = Animation.easeInOut(duration: speed).repeatForever(autoreverses: true)
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
        MeditationView(mood: .mindDistraction)
    }
}
