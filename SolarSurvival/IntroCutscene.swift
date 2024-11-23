//
//  IntroCutscene.swift
//  SolarSurvival
//
//  Created by T Krobot on 23/11/24.
//
import SwiftUI

struct IntroCutsceneShow: View {
    @State private var currentIndex = 0
    @State private var showNextView = false
    @State private var canSkip = false // Tracks if skipping is allowed
    @State private var timer: Timer?
    
    let images = ["Introtemp1", "Introtemp2", "Introtemp3", "Introtemp4", "Introtemp5", "Intrograv1", "Intrograv2", "Intrograv3", "Intrograv4", "Intrograv5", "Intrograv6", "Intrograv7", "Intrograv8_2", "Intrograv7", "Intrograv6", "Intrograv5", "Intrograv4", "Intrograv3"] // Replace with your image names
    let durations: [ClosedRange<Double>] = [
        1.5...2.5, // Duration range for image 1
        1.5...2.5, // Duration range for image 2
        1.5...2.5, // Duration range for image 3
        1.5...2.5,  // Duration range for image 4
        1.5...2.5,
        2.0...3.0,
        2.0...3.0,
        1.5...2.5,
        0.2...0.5,
        0.2...0.5,
        0.2...0.5,
        0.2...0.5,
        1.5...2.5,
        0.2...0.5,
        0.2...0.5,
        0.2...0.5,
        0.2...0.5,
        1.5...2.5
    ]
    
    var body: some View {
        Group {
            if showNextView {
                HomePage() // Next view after the slideshow
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
                    if canSkip {
                        skipToNextImage()
                    }
                }
            }
        }
    }
    
    private func startSlideshow() {
        if currentIndex >= images.count {
            finishSlideshow() // Trigger transition to next view
            return
        }
        
        // Reset skipping ability
        canSkip = false
        
        // Get duration range for the current image
        let durationRange = durations[safe: currentIndex] ?? 3.0...5.0
        let minTime = durationRange.lowerBound
        let maxTime = durationRange.upperBound
        
        // Allow skipping after `minTime`
        DispatchQueue.main.asyncAfter(deadline: .now() + minTime) {
            canSkip = true
        }
        
        // Schedule automatic transition after `maxTime`
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: maxTime, repeats: false) { _ in
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
    
    private func finishSlideshow() {
        timer?.invalidate()
        withAnimation {
            showNextView = true // Move to the next view
        }
    }
}

#Preview {
    IntroCutsceneShow()
}

