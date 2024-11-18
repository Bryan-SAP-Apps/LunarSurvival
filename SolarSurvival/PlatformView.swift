import SwiftUI
struct PlatformView: View {
    @StateObject private var gameState = GameState()
    @State private var isJumping = false
    @State private var gravity = CGFloat(5)
    @State private var velocity = CGFloat(0)
    @State private var isMovingLeft = false
    @State private var isMovingRight = false
    @State private var isOnPlatform = false
    @State private var endPoint = false
    @State private var gameTimer: Timer? = nil
    @StateObject var itemManager = ItemManager()
    //    @State private var itemManager.items = item
    @State private var platforms: [Platform] = []
    @State private var collectibles: [Collectible] = []
    @State private var stars: [CGPoint] = []
    @State private var astronaut = "astronaut1"
    @State private var metalItem = 0
    
    let groundLevel: CGFloat = 300
    let jumpStrength: CGFloat = -5
    let frameDuration = 0.016
    
    let platformXPositions: [CGFloat] = [150, 400, 650] // Fixed X positions for platforms
    var items = [
        Item(name: "metal", amount: 0),
        Item(name: "regolith", amount: 0),
        Item(name: "glass", amount: 0),
        Item(name: "rubber", amount: 0),
        Item(name: "plastic", amount: 0),
        Item(name: "electronics", amount: 0)
    ]
    var body: some View {
        //        @Binding var item = item
        NavigationStack{
            NavigationLink(destination: NextLevelView(), isActive: $endPoint) {
                EmptyView()
            }.onAppear {
                gameState.currentLevel = 1
                if gameState.playerPosition.x != 200 {
                    stopGameLoop()
                    gameState.playerPosition.x = 750 // Set position when coming back
                }
                generatePlatforms() // Call function to generate platforms and coins
                generateStars() // Call function to generate stars in the background
            }
            
            ZStack {
                // Black background with stars
                Color.black.ignoresSafeArea()
                
                // Add stars to the background
                ForEach(stars.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.white)
                        .frame(width: 2, height: 2)
                        .position(stars[index])
                }
                
                .onDisappear {
                    // Cleanup code when the view disappears, to ensure nothing is retained.
                    resetGameState()
                    stopGameLoop()  // Ensure we stop all running processes
                }
                
                // Ground
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 1400, height: 50)
                    .position(x: 200, y: groundLevel + 25)
                
                // Platforms
                ForEach(platforms.indices, id: \.self) { index in
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: platforms[index].size.width, height: platforms[index].size.height)
                        .position(platforms[index].position)
                        .rotation3DEffect(
                            .degrees(45),
                            axis: (x: 1.0, y: 0.0, z: 0.0)
                        )
                }
                
                // Collectibles (Coins)
                ForEach(collectibles.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 20, height: 20)
                        .position(collectibles[index].position)
                }
                
                // Player
                Image(astronaut)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .position(gameState.playerPosition)
                
                // Calculate totals for each material
                VStack {
                    HStack(alignment: .center) {
                        ForEach(itemManager.items, id: \.id) { item in
                            HStack {
                                // Display Image (ensure the image exists in your assets)
                                Image(item.name) // Replace `imageName` with your image property
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50) // Adjust the frame size as needed
                                    .cornerRadius(8)
                                
                                // Display Name and Amount
                                Text("\(item.amount)")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        Spacer()
                    }
                            .padding()
                            
                            Spacer() // Push the rest of the content below
                        }
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Controls
                VStack {
                    Spacer()
                    HStack {
                        Button(action: { }) {
                            Text("←")
                                .font(.largeTitle)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        }
                        .simultaneousGesture(DragGesture(minimumDistance: 0)
                            .onChanged { _ in startMovingLeft()
                                astronaut="astronaut3" }
                            .onEnded { _ in stopMovingLeft()
                            astronaut="astronaut1"})
                        
                        Button(action: { }) {
                            Text("→")
                                .font(.largeTitle)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        }
                        .simultaneousGesture(DragGesture(minimumDistance: 0)
                            .onChanged { _ in startMovingRight()
                                astronaut="Astronaut2"}
                            .onEnded { _ in stopMovingRight()
                            astronaut="astronaut1"})
                        Spacer()
                        Button(action: { jump() }) {
                            Text("↑")
                                .font(.largeTitle)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        }
                    }.padding()
                }
            }
            .onAppear {
                startGameLoop()
            }
            .onDisappear {
                stopGameLoop()  // Stop the game loop when the view is no longer active
                stopMovingLeft()  // Optionally stop any movement
                stopMovingRight()  // Optionally stop any movement
            }
            
        }.navigationBarBackButtonHidden(true)
    }
    
    func generatePlatforms() {
        // Clear all old platforms and collectibles explicitly
        platforms.removeAll(keepingCapacity: false)
        collectibles.removeAll(keepingCapacity: false)
        
        // Randomly generate new platforms and coins for the new level
        for xPosition in platformXPositions {
            // Random Y position for each platform, keeping them spaced out
            let randomY = CGFloat.random(in: 150...250)
            let platform = Platform(position: CGPoint(x: xPosition, y: randomY), size: CGSize(width: 150, height: 20))
            platforms.append(platform)
            
            // 60% chance of spawning a coin on top of the platform
            if Bool.random() {
                let coin = Collectible(position: CGPoint(x: xPosition, y: randomY - 20)) // Coin on top of platform
                collectibles.append(coin)
            }
        }
    }
    
    
    
    func generateStars() {
        stars.removeAll()
        
        // Generate 100 random stars on the screen
        for _ in 0..<100 {
            let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
            let y = CGFloat.random(in: 0...UIScreen.main.bounds.height)
            stars.append(CGPoint(x: x, y: y))
        }
    }
    
    func resetGameState() {
        // Resetting player position and other state
        gameState.playerPosition = CGPoint(x: 200, y: groundLevel)
        gameState.score = 0
        
        // Reset movement states
        isJumping = false
        velocity = 0
        isOnPlatform = false
        isMovingLeft = false
        isMovingRight = false
        
        // Explicitly nil-out references
        platforms.removeAll()
        collectibles.removeAll()
        stars.removeAll()
        
        // Make sure all other views, animations, or observers are stopped
        // For example, remove all animations if present
    }
    
    
    func startMovingLeft() {
        isMovingLeft = true
    }
    
    func stopMovingLeft() {
        isMovingLeft = false
    }
    
    func startMovingRight() {
        isMovingRight = true
    }
    
    func stopMovingRight() {
        isMovingRight = false
    }
    
    func startGameLoop() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            updateGame()
        }
    }
    
    func stopGameLoop() {
        gameTimer?.invalidate()  // Invalidate the timer if it's running
        gameTimer = nil  // Set the timer to nil to ensure it doesn't hold onto memory
    }
    
    
    func updateGame() {
        // Apply gravity and update player's position
        if isJumping {
            velocity += gravity * frameDuration
            gameState.playerPosition.y += velocity
        }
        
        var currentlyOnPlatform = false
        
        // Check if player has landed on the ground or on any platform
        if !currentlyOnPlatform {
            velocity += gravity * frameDuration
            gameState.playerPosition.y += velocity
        }
        
        if gameState.playerPosition.y >= groundLevel {
            gameState.playerPosition.y = groundLevel
            velocity = 0
            isJumping = false
            currentlyOnPlatform = true
        } else {
            for platform in platforms {
                if abs(gameState.playerPosition.x - platform.position.x) < (20 + platform.size.width / 2) &&
                    abs(gameState.playerPosition.y - platform.position.y) < (20 + platform.size.height / 2) &&
                    velocity >= 0 {
                    gameState.playerPosition.y = platform.position.y - 20
                    velocity = 0
                    isJumping = false
                    currentlyOnPlatform = true
                    break
                }
            }
        }
        
        // Update isOnPlatform
        isOnPlatform = currentlyOnPlatform
        
        // Move player left or right if buttons are pressed
        if isMovingLeft {
            movePlayer(left: true)
        }
        if isMovingRight {
            movePlayer(left: false)
        }
        
        // Check for collectible items
        checkCollectibleCollision()
        
        // Trigger level transition if necessary
        if gameState.playerPosition.x >= 750 {
            endPoint = true
            gameState.savedPositions[gameState.currentLevel] = gameState.playerPosition
        }
    }
    
    func jump() {
        if !isJumping && (gameState.playerPosition.y >= groundLevel || isOnPlatform) {
            velocity = jumpStrength
            isJumping = true
            isOnPlatform = false
        }
    }
    
    func movePlayer(left: Bool) {
        gameState.playerPosition.x += left ? -10 : 10
        gameState.playerPosition.x = max(20, min(gameState.playerPosition.x, 1380))
    }
    
    func checkCollectibleCollision() {
        for index in (0..<collectibles.count).reversed() {  // Iterating backwards to avoid issues when removing elements
            let collectible = collectibles[index]
            let distanceX = abs(gameState.playerPosition.x - collectible.position.x)
            let distanceY = abs(gameState.playerPosition.y - collectible.position.y)
            
            // Print distances for debugging
            // print("Checking collectible at index \(index): X distance = \(distanceX), Y distance = \(distanceY)")
            
            if distanceX < 20 && distanceY < 20 {
                // Print when a collision is detected
                print("Collision detected with collectible at index \(index)")
                
                // Optionally, print the collectible details if needed
                // print("Collectible details: \(collectible)")
                
                collectibles.remove(at: index)
                
                // Print details before calling the incrementRandomProperty function
                print("Before incrementRandomProperty: ") // Replace 'someProperty' with an actual property
                
                // Call incrementRandomProperty() method
                itemManager.addRandomItemAmount()
                
                // Print details after calling the incrementRandomProperty function
                print("After incrementRandomProperty") // Replace 'someProperty' with an actual property
                
                break
            }
        }
    }


    func generateNewLevel() {
        stopGameLoop()  // Stop the game loop before resetting the level
        resetGameState()  // Reset the game state
        generatePlatforms()  // Generate the new level's platforms
        generateStars()  // Generate new stars, etc.
        startGameLoop()  // Restart the game loop for the new level
    }
    
}
#Preview {
    PlatformView()
}
