//
//  ImageCutsceneTextYouCanCopy.swift
//  SolarSurvival
//
//  Created by T Krobot on 23/11/24.
//
import SwiftUI

struct DayTransitionCutscene: View {
    @Binding var day : Int// The current day to determine the second image
    let onFinish: () -> Void // Callback for when the slideshow ends
    
    @State private var currentIndex = 0
    @State private var showNextView = false
    var images = ["Solar Rain", "TempDay1", "TempDay2", "TempDay3", "TempDay4", "TempDay5", "TempDay6", "TempDay7"] // Replace with your image names
    let minTime: Double = 2.0
    let maxTime: Double = 4.0
    
    @State private var timer: Timer?
   
    init(day: Int, onFinish: @escaping () -> Void) {
            self._day = Binding.constant(day) // Initialize the day as a constant binding
            self.onFinish = onFinish
            
            // Initialize images with solar wind + day-specific image
            self.images = ["Solar Rain", "TempDay\(day)"]
        }
    
    var body: some View {
        Group {
            if showNextView {
                AfterEndDay() // Replace with your next view
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
            onFinish()
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
    AfterEndDay()
}

