import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameState()
    @State private var isJumping = false
    @State private var gravity = CGFloat(5)
    @State private var velocity = CGFloat(0)
    @State private var score = 0
    @State private var isMovingLeft = false
    @State private var isMovingRight = false
    @State private var isOnPlatform = false
    @State private var endPoint = false
    
    @State private var platforms: [Platform] = []
    @State private var collectibles: [Collectible] = []
    
    let groundLevel: CGFloat = 300
    let jumpStrength: CGFloat = -5
    let frameDuration = 0.016
    
    let platformXPositions: [CGFloat] = [200, 400, 600] // Fixed X positions for platforms

    var body: some View {
        NavigationStack{
            NavigationLink(destination: NextLevelView(), isActive: $endPoint) {
                EmptyView()
            }.onAppear {
                gameState.currentLevel = 1
                if gameState.playerPosition.x != 200 {
                    gameState.playerPosition.x = 750 // Set position when coming back
                }
                generatePlatforms() // Call function to generate platforms and coins
            }
            
            ZStack {
                // Background
                Color.blue.ignoresSafeArea()
                
                // Ground
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 1400, height: 50)
                    .position(x: 200, y: groundLevel + 25)
                
                // Player
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 40, height: 40)
                    .position(gameState.playerPosition)
                
                // Platforms
                ForEach(platforms.indices, id: \.self) { index in
                    Rectangle()
                        .fill(Color.brown)
                        .frame(width: platforms[index].size.width, height: platforms[index].size.height)
                        .position(platforms[index].position)
                }
                
                // Collectibles (Coins)
                ForEach(collectibles.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 20, height: 20)
                        .position(collectibles[index].position)
                }
                
                // Score display
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .position(x: 100, y: 50)
                
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
                            .onChanged { _ in startMovingLeft() }
                            .onEnded { _ in stopMovingLeft() })
                        
                        Button(action: { }) {
                            Text("→")
                                .font(.largeTitle)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        }
                        .simultaneousGesture(DragGesture(minimumDistance: 0)
                            .onChanged { _ in startMovingRight() }
                            .onEnded { _ in stopMovingRight() })
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
                stopMovingLeft()
                stopMovingRight()
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func generatePlatforms() {
        platforms.removeAll()
        collectibles.removeAll()
        
        // Randomly generate platforms and coins
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
        Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            updateGame()
        }
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
        for index in collectibles.indices {
            let collectible = collectibles[index]
            if abs(gameState.playerPosition.x - collectible.position.x) < 20 &&
                abs(gameState.playerPosition.y - collectible.position.y) < 20 {
                collectibles.remove(at: index)
                score += 1
                break
            }
        }
    }
}
