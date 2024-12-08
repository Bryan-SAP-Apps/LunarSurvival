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
    @State private var canSkip = false
    @State private var timer: Timer?
    @State private var cutsceneTimes = 0
    @AppStorage("hasSeenCutscene") private var hasSeenCutscene = false
    @AppStorage("shouldPlayCutscene") private var shouldPlayCutscene = false
    // Persistent flag
    
    let images = ["CImg-1","CImg0","startcutscene1-2","CImg1", "CImg2", "CImg3", "CImg4", "CImg5", "CImg6", "CImg7", "CImg8", "CImg9", "CImg10", "CImg11", "CImg12", "CImg13", "CImg14", "CImg15", "CImg16"] // Replace with your image names
    let durations: [ClosedRange<Double>] = [
        0.5...1.0, //start
        1.5...2.5, //title
        1.0...2.0, //oneday
        0.5...1.0, //1
        0.5...1.0, //2
        0.5...1.0, //3
        0.5...1.0, //4
        1.5...2.5, //5
        1.5...2.5, //6
        1.5...2.5, //7
        1.5...2.5, //8
        1.5...2.5, //9
        2.5...4.5, //10
        3.0...5.5, //11
        2.5...4.5, //12
        3.0...5.5, //13
        2.5...4.5, //14
        3.0...5.5, //15
        4.0...6.5 //16
    ]
    
    var body: some View {
        Group {
            if showNextView {
                NavigationStack {
                    StartView() // Pass callback
                }
            } else {
                
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all) // Background color
                    
                    if let currentImage = images[safe: currentIndex] {
                        AsyncImage(name: currentImage) // Lazy-loaded image
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                    }
                    
                    // Skip Button
                    if cutsceneTimes >= 1 {
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    finishCutscene()
                                }) {
                                    Text("Skip")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.red)
                                        .cornerRadius(8)
                                }
                                .padding()
                            }
                            Spacer()
                        }
                    }
                }
                .onAppear {
                                    if shouldPlayCutscene {
                                        resetCutscene()
                                    } else if !hasSeenCutscene {
                                        startSlideshow()
                                    } else {
                                        showNextView = true
                                    }
                                }
                                .onChange(of: shouldPlayCutscene) { newValue in
                                    if newValue {
                                        resetCutscene()
                                    }
                                }
                                .onTapGesture {
                                    if canSkip {
                                        skipToNextImage()
                                    }
                                }
            }
        }.navigationBarBackButtonHidden()
    }
    
    private func startSlideshow() {
        if currentIndex >= images.count {
            finishCutscene()
            return
        }
        //hasSeenCutscene = true
        // Reset skipping ability
        canSkip = false
        
        // Get duration range for the current image
        let durationRange = durations[safe: currentIndex] ?? 3.0...5.0
        let minTime = durationRange.lowerBound
        let maxTime = durationRange.upperBound
        
        // Schedule timer for min time to allow skipping
        DispatchQueue.main.asyncAfter(deadline: .now() + minTime) {
            canSkip = true
        }
        
        // Schedule timer for automatic transition after max time
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
    
    func playCutscene() {
        currentIndex = 0
        showNextView = false
        hasSeenCutscene = false
        cutsceneTimes += 1
    }
    private func resetCutscene() {
        currentIndex = 0
        showNextView = false
        hasSeenCutscene = false
        cutsceneTimes += 1
        shouldPlayCutscene = false // Reset the trigger
        startSlideshow()
    }

    private func finishCutscene() {
        timer?.invalidate()
        hasSeenCutscene = true // Mark cutscene as seen
        showNextView = true
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
