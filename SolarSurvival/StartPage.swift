import SwiftUI
import SDWebImageSwiftUI

struct StartView: View {
    @State private var isNavigated = false
    @State private var isAnimated = true
    @State private var continuee = false
    @State private var start = "Start/Continue"
    @AppStorage("1")var building1 = ""
    @AppStorage("2")var building2 = ""
    @AppStorage("3")var building3 = ""
    @AppStorage("4")var building4 = ""
    @AppStorage("5")var building5 = ""
    @AppStorage("5")var building6 = ""
    @AppStorage("day") var day = 0
    var playCutscene: () -> Void // Callback to play cutscene again
    
    var body: some View {
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
                                    playCutscene() // Call the playCutscene closure
                                }) {
                                    Text("Play Cutscene Again")
                                        .padding(.all, 10)
                                        .background(Color.blue)
                                        .foregroundStyle(.white)
                                        .font(.caption2)
                                }
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.top, 40)
                                Spacer()
                            }
                            Spacer()
                        }
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
                                building1 = ""
                                building2 = ""
                                building3 = ""
                                building4 = ""
                                building5 = ""
                                building6 = ""
                                day = 0
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
        .navigationBarBackButtonHidden()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        // Ensure GameState and Player are properly initialized
        let gameState = GameState()  // Create an instance of GameState
        let player = Player(startPosition: CGPoint(x: 200, y: 300))  // Create an instance of Player
        
        // Provide a simple mock closure for playCutscene
        return StartView(playCutscene: {
            // Mock behavior for the playCutscene callback
            print("Cutscene played")
        })
        .environmentObject(gameState)  // Inject GameState to the view
        .environmentObject(player)     // Inject Player to the view
    }
}
