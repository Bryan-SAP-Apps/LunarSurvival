//
//  CongratView.swift
//  SolarSurvival
//
//  Created by T Krobot on 15/11/24.
//
import SwiftUI
import SDWebImageSwiftUI

struct CongratView: View {
    @EnvironmentObject var buildingManager: BuildingManager
    @StateObject var energyManager = EnergyManager()
    @AppStorage("daysForRescue") var daysForRescue = 3
    @StateObject var itemManager = ItemManager()
    @State private var isNavigated = false // State variable to control navigation
    @Environment(\.dismiss) var dismiss
    @State var continuee = false
    @State var start = "Start"
    @State var isAnimated = true
    @AppStorage("day") var day = 1
    @AppStorage("structure") var goodStructure = true
    
    
    var body: some View {
            Color(red: 0.01, green: 0.10, blue: 0.40)
                .ignoresSafeArea()
                .overlay(
                    ZStack{
                        
                    VStack{
                        Text("Congratulations!")
                            .font(.system(size: 50))
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                        
                        VStack{
                            HStack{
                                VStack{
                                    VStack{
                                        Text("Days survived:")
                                            .font(.title)
                                            .foregroundColor(.white)
                                        Text("\(day)")
                                            .monospaced()
                                            .foregroundColor(.white)
                                            .font(.title)
                                    }
                                    .padding()
                                        
                                    VStack{
                                        Text("Infrastructure built: ")
                                            .font(.title)
                                            .foregroundColor(.white)
                                        Text("\(buildingManager.totalBuildingsWithImageName())")
                                            .monospaced()
                                            .foregroundColor(.white)
                                            .font(.title)
                                        
                                    }
                                }
                                Spacer()
                                VStack{
                                    
                                    VStack{
                                        Text("Total Resources: ")
                                            .font(.title)
                                            .foregroundColor(.white)
                                        Text("\(itemManager.totalItemAmount)")
                                            .monospaced()
                                            .foregroundColor(.white)
                                            .font(.title)
                                        
                                    }

                                }
                            }
                        }
                        Spacer()
                        HStack{
                        Spacer()
                        Button(action: {
                             isNavigated = true // Set the state to true to navigate
                            daysForRescue = 3
                            day = 1
                            buildingManager.clearImageNames()
                            energyManager.clearEnergyAmount()
                            itemManager.resetItemAmounts()
                            if (continuee == false){
                                start = "Start"
                            } else {
                                start = "Continue"
                            }
                        }) {
                            Text("Restart game")
                                .font(.title)
                                .padding()
                                .padding(.trailing, 20)
                                .padding(.leading, 20)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            
                            
                        }
                    }
                    }
                        VStack{
                            
                            AnimatedImage(name: "Rocket1.png", isAnimating: $isAnimated)
                                .resizable()
                                .scaledToFit()
                                .padding(.top, 35)
                                
                    }
                    }
                )
            
            // Programmatic NavigationLink
        NavigationLink(destination: CutsceneSlideshow(), isActive: $isNavigated) {
                EmptyView() // Use an empty view for the link
        }.navigationBarBackButtonHidden()
    }
    
}

struct CongratView_Previews: PreviewProvider {
    static var previews: some View {
        let gameState = GameState()  // Create an instance of GameState
        let player = Player(startPosition: CGPoint(x: 200, y: 300))  // Create an instance of Player
        
        return CongratView()
            .environmentObject(gameState)  // Pass GameState to the view
            .environmentObject(player)
            .environmentObject(BuildingManager())
            .environmentObject(ItemManager())// Pass Player to the view
    }
}
