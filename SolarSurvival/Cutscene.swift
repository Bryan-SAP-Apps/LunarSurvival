//
//  Cutscene.swift
//  SolarSurvival
//
//  Created by T Krobot on 18/11/24.
//
import SwiftUI

struct CutsceneSlideshow: View {
    @State private var currentIndex = 0
    @State private var showNextView = false
    let images = ["CImg1", "CImg2", "CImg3", "CImg4","CImg5","CImg6","CImg7","CImg8","CImg9","CImg10","CImg11","CImg12","CImh13","CImg14","CImg15","CImg16"] // Replace with your image names
    let durations: [ClosedRange<Double>] = [
        2.0...4.0,//1
        2.0...4.0,//2
        2.0...4.0,//3
        2.0...4.0,//4
        3.0...4.0,//5
        3.0...4.0,//6
        3.0...4.0,//7
        3.0...4.0,//8
        3.0...4.0,//9
        4.0...6.0,//10
        4.0...6.0,//11
        4.0...6.0,//12
        4.0...6.0,//13
        4.0...6.0,//14
        4.0...6.0,//15
        5.0...7.0 //16
    ]
    
    @State private var timer: Timer?
    
    var body: some View {
        Group {
            if showNextView {
                StartView() // Replace with your next view
            } else {
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all) // Background color
                    if let currentImage = images[safe: currentIndex] {
                        AsyncImage(name: currentImage) // Lazy-loaded image
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                    }
                }
                .onAppear {
                    startSlideshow()
                }
                .onTapGesture {
                    skipToNextImage()
                }
            }
        }
    }
    
    private func startSlideshow() {
        if currentIndex >= images.count {
            showNextView = true
            return
        }
        
        // Use the specific duration range for the current image
        let displayTime = Double.random(in: durations[safe: currentIndex] ?? 3.0...5.0)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: displayTime, repeats: false) { _ in
            withAnimation {
                currentIndex += 1
                startSlideshow()
            }
        }
    }
    
    private func skipToNextImage() {
        timer?.invalidate()
        withAnimation {
            currentIndex += 1
            startSlideshow()
        }
    }
}


// Safe array indexing to prevent crashes
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// Lazy-loaded image using AsyncImage
struct AsyncImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .resizable()
    }
}

#Preview {
    CutsceneSlideshow()
}
