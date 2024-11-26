//
//  ImageCutsceneTextYouCanCopy.swift
//  SolarSurvival
//
//  Created by T Krobot on 23/11/24.
//
import SwiftUI

struct DayTransitionCutscene: View {
    let onFinish: () -> Void // Callback for when the slideshow ends
    @EnvironmentObject var buildingManager: BuildingManager
    @State private var goGood = false
    @State private var goDie = false
    
    @State private var currentIndex = 0
    @AppStorage("survived") var survived = false
    @State private var showNextView = false
    @State private var view = ""
    @AppStorage("day") var day = 1
    var images = ["Solar Rain", "TempDay1", "TempDay2", "TempDay3", "TempDay4", "TempDay5", "TempDay6", "TempDay7"] // Replace with your image names
    let minTime: Double = 2.0
    let maxTime: Double = 4.0
    
    @State private var timer: Timer?
   
    init(onFinish: @escaping () -> Void) {
            self.onFinish = onFinish
            
            // Initialize images with solar wind + day-specific image
            self.images = ["Solar Rain", "TempDay\(day)"]
        }
    
    var body: some View {
        NavigationStack{
            NavigationLink(
                destination: HomePage(), isActive: $goGood){
                    EmptyView()
                }
            NavigationLink(
                destination: DeathView(), isActive: $goDie){
                    EmptyView()
                }
            Group {
                if showNextView {
                    
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
    }
    private func startSlideshow() {
        if currentIndex >= images.count {
            liveOrDie()
            showNextView = true
            onFinish()
            day += 1
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
    private func liveOrDie(){
        print("Day: \(day)")
        print("Buildings: \(buildingManager.buildings)")

        print("Day: \(day)")
        print("Buildings: \(buildingManager.buildings)")

        switch day {
        case 1:
            if buildingManager.buildings.contains { $0.imageName.contains("basicshelter") } &&
               buildingManager.buildings.contains { $0.imageName.contains("regolithinsulation") } {
                survived = true
                goGood = true
            } else {
                goDie = true
            }
        case 2:
            print("Checking for co2filter...")
            if buildingManager.buildings.contains { $0.imageName.contains("co2filter") } {
                survived = true
                goGood = true
            } else {
                goDie = true
            }
        case 3:
            print("Checking for solarpanels...")
            if buildingManager.buildings.contains { $0.imageName.contains("solarpanel") } {
                survived = true
                goGood = true
            } else {
                goDie = true
            }
        default:
            goDie = true
        }

    }
}


