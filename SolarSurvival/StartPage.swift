import SwiftUI
import SDWebImageSwiftUI

struct StartView: View {
    @State private var isNavigated = false
    @State private var isAnimated = true
    @AppStorage("continuee") var continuee = false
    @State private var start = "Start"
    @AppStorage("day") var day = 1
    @AppStorage("eat") var eat = 0
    @EnvironmentObject var buildingManager: BuildingManager
    @StateObject var energyManager = EnergyManager()
    @StateObject var itemManager = ItemManager()
    @AppStorage("daysForRescue") var daysForRescue = 3
    @AppStorage("shouldPlayCutscene") private var shouldPlayCutscene = false
    
    // Callback to play cutscene again
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(red: 0.01, green: 0.1, blue: 0.4)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        ZStack {
                            VStack {
                                HStack {
                                    // Existing content of the view goes here
                                    Button(action: {
                                        shouldPlayCutscene = true// Call the playCutscene closure
                                    }) {
                                        Text("Play Cutscene Again")
                                            .padding(.all, 10)
                                            .background(Color.blue)
                                            .foregroundStyle(.white)
                                            .font(.caption2)
                                            
                                    }
                                
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                        }
                        .background {
                            AnimatedImage(name:"Homepage.gif", isAnimating: $isAnimated)
                        }
                        
                        VStack {
                            Text("Lunar")
                                .font(.system(size: 50))
                                .bold()
                                .foregroundStyle(.white)
                            Text("Survival")
                                .font(.system(size: 50))
                                .bold()
                                .foregroundStyle(.white)
                            
                            VStack {
                                // Button to navigate to the second view
                                Button(action: {
                                    isNavigated = true // Set the state to true to navigate
                                    continuee = true
                                    if (continuee == false) {
                                        start = "Start"
                                    } else {
                                        start = "Continue"
                                    }
                                }) {
                                    Text(start)
                                        .font(.title)
                                        .padding()
                                        .frame(width: 300)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                
                                Button(action: {
                                    day = 1
                                    daysForRescue = 3
                                    eat = 0
                                    energyManager.clearEnergyAmount()
                                    buildingManager.clearImageNames()
                                    itemManager.resetItemAmounts()
                                    if (continuee == false) {
                                        start = "Start"
                                    } else {
                                        start = "Continue"
                                    }
                                }) {
                                    Text("Reset")
                                        .font(.title)
                                        .padding()
                                        .frame(width: 300)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.trailing)
                        }
                    }
                    
                    HStack {
                        Spacer()
                    }
                }
            }
            // Programmatic NavigationLink
            NavigationLink(destination: IntroCutsceneShow(), isActive: $isNavigated) {
                EmptyView() // Use an empty view for the link
            }
            NavigationLink(destination: CutsceneSlideshow(), isActive: $shouldPlayCutscene) {
                EmptyView() // Use an empty view for the link
            }
            .navigationBarBackButtonHidden()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        // Ensure GameState and Player are properly initialized
        let gameState = GameState()  // Create an instance of GameState
        let player = Player(startPosition: CGPoint(x: 200, y: 300))  // Create an instance of Player
        
        // Provide a simple mock closure for playCutscene
        StartView()
            .environmentObject(gameState)  // Inject GameState to the view
            .environmentObject(player)     // Inject Player to the view
    }
}
