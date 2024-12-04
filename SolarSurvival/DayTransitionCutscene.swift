//
//  ImageCutsceneTextYouCanCopy.swift
//  SolarSurvival
//
//  Created by T Krobot on 23/11/24.
//
import SwiftUI

struct DayTransitionCutscene: View {
    
    let onFinish: () -> Void // Callback for when the slideshow ends
//    @StateObject var alertManager = AlertManager()
    @EnvironmentObject var buildingManager: BuildingManager
    @EnvironmentObject var itemManager: ItemManager
    @EnvironmentObject var energyManager: EnergyManager
    @EnvironmentObject var alertManager: AlertManager
    @State private var goGood = false
    @State private var goDie = false
    @State private var goEnd = false
    @AppStorage("eat") var eat = 0
    @State private var currentIndex = 0
    @AppStorage("justDied") var justDied = false
    @AppStorage("survived") var survived = false
    @State private var showNextView = false
    @State private var view = ""
    @AppStorage("day") var day = 1
    var images = ["Solar Rain", "TempDay1", "TempDay2", "TempDay3", "TempDay4", "TempDay5", "TempDay6", "TempDay7"] // Replace with your image names
    @State private var electricstable = false
    
    @AppStorage("rescue") var rescued = false
    @AppStorage("daysForRescue") var daysForRescue = 3
    
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
                NavigationLink(destination: EndCutsceneShow(), isActive: $goEnd){
                    EmptyView()
                }
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
            .navigationBarBackButtonHidden()
        }
    }
    private func checkRescueOrEnd() {
            if buildingManager.buildings.contains(where: { $0.imageName.contains("highgainantenna") }) {
                daysForRescue -= 1
                rescued = true
                if daysForRescue <= 0 {
                    survived = false
                    rescued = false
                    goEnd = true
                } else {
                    showNextView = true
                }
                goGood = true
            }
        }
    private func startSlideshow() {
        if currentIndex >= images.count {
                   checkRescueOrEnd()
                   liveOrDie()
                   onFinish()
            if justDied == true{
                day = 1
            } else{
                day += 1
            }
                   
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
    private func restart(){
        
        daysForRescue = 3
        day = 1
        eat = 0
        justDied = true
        buildingManager.clearImageNames()
        energyManager.clearEnergyAmount()
        itemManager.resetItemAmounts()
        print(itemManager.items)
    }
    private func liveOrDie() {
        switch day {
        case 1:
            if buildingManager.buildings.contains { $0.imageName.contains("basicshelter") } &&
               buildingManager.buildings.contains { $0.imageName.contains("regolithinsulation") } {
                survived = true// Triggers the alert
                goGood = true
            } else {
                restart()
                goDie = true
                // to initialise death even if user quits game at next page
                
            }
        case 2:
            if buildingManager.buildings.contains { $0.imageName.contains("co2filter") } {
                survived = true
                goGood = true
            } else {
                restart()
                goDie = true
            }
        case 3:
            if buildingManager.buildings.contains { $0.imageName.contains("solarpanel") } {
                survived = true
                electricstable = true
                goGood = true
            } else {
                restart()
                goDie = true
            }
        case 7...:
            restart()
            goDie = true
        default:
            survived = true
            goGood = true
        }
    }
}


