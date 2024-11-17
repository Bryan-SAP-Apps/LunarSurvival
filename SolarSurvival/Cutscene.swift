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
    let images = ["image1", "image2", "image3", "image4"] // Replace with your image names
    let durations: [ClosedRange<Double>] = [
        3.0...5.0, // Duration range for image 1
        4.0...6.0, // Duration range for image 2
        2.0...4.0, // Duration range for image 3
        5.0...7.0  // Duration range for image 4
    ]
    
    @State private var timer: Timer?
    
    var body: some View {
        Group {
            if showNextView {
                PlaceholderView() // Replace with your next view
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

// Placeholder view for the next screen
struct PlaceholderView: View {
    var body: some View {
        Text("Next Screen!")
            .font(.largeTitle)
            .foregroundColor(.blue)
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
