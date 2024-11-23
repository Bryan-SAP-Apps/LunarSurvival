//
//  ImageCutsceneTextYouCanCopy.swift
//  SolarSurvival
//
//  Created by T Krobot on 23/11/24.
//
import SwiftUI

struct OptimizedFullscreenSlideshow: View {
    @State private var currentIndex = 0
    @State private var showNextView = false
    let images = ["image1", "image2", "image3", "image4"] // Replace with your image names
    let minTime: Double = 2.0
    let maxTime: Double = 4.0
    
    @State private var timer: Timer?
    
    var body: some View {
        Group {
            if showNextView {
                HomePage() // Replace with your next view
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
        
        let displayTime = Double.random(in: minTime...maxTime)
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


#Preview {
    OptimizedFullscreenSlideshow()
}

