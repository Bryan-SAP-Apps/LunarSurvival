import SwiftUI

struct NextLevelView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var player: Player
    
    @State private var showNextLevelButton = true
    @State private var goHomePage = false
    
    var body: some View {
        NavigationStack{
            NavigationLink(destination: HomePage(), isActive: $goHomePage) {
                EmptyView()
            }
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    Text("Level \(gameState.currentLevel) Complete!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    
                    Text("Congratulations!")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    // Show next level button if it's not the last level
                    if showNextLevelButton {
                        Button(action: nextLevel) {
                            Text("Next Level")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                                .padding(.bottom, 50)
                        }
                        .disabled(gameState.currentLevel == gameState.totalLevels) // Disable button if it's the last level
                    }
                    
                    Spacer()
                    
                    // Show main menu button
                    Button(action: backToMainMenu) {
                        Text("Back to Main Menu")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                    }
                }
                .padding()
            }
            .onAppear(perform: updateGameProgress)
        }
    }
    
    // Function to proceed to the next level
    private func nextLevel() {
        gameState.currentLevel += 1
        // Reset player position for next level
        player.position = CGPoint(x: 200, y: 300)
        showNextLevelButton = false // Hide next level button
        // Add more logic here to load the new level if needed
    }
    
    // Function to go back to the main menu
    private func backToMainMenu() {
        // Logic to navigate back to the main menu, e.g., popping the view or resetting the game
        gameState.reset()
        player.resetPosition()
        print("click back to main menu: \(player.position)")
        goHomePage = true
        
    }
    
    private func updateGameProgress() {
        // Update game progress or perform any additional actions needed
    }
}

struct NextLevelView_Previews: PreviewProvider {
    static var previews: some View {
        var player = Player(startPosition: CGPoint(x: 200, y: 300))
        let gameState = GameState()  // Create an instance of GameState
        NextLevelView()
            .environmentObject(gameState)  // Pass GameState to the view
            .environmentObject(player)  // Pass Player to the view
    }
}
