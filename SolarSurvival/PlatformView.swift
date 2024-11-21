import SwiftUI

struct PlatformView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var player: Player
    
    @State private var platforms: [Platform] = []
    @State private var collectibles: [Collectible] = []
    @State private var stars: [CGPoint] = []
    @State private var endPoint = false
    @State private var gameTimer: Timer? // Correctly define gameTimer here
    @State private var path = NavigationPath()
    @Binding var isSecondView: Bool
    
    private let groundLevel: CGFloat = 300
    private let frameDuration = 0.016
    private let platformXPositions: [CGFloat] = [150, 400, 650]
    
    @StateObject private var itemManager = ItemManager()

    private func displayScoreAndInventory() -> some View {
        VStack {
            HStack {
                Text("Score: \(gameState.score)")
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
                VStack {
                    Text("Inventory")
                        .font(.headline)
                        .foregroundColor(.white)
                    ForEach(gameState.inventory.keys.sorted(), id: \.self) { item in
                        HStack {
                            Text("\(item): \(gameState.inventory[item]!)")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
            }
            .padding()
            Spacer()
        }
    }

    var body: some View {
        NavigationStack(path: $path){
//            NavigationLink(destination: NextLevelView(), isActive: $endPoint) {
//                EmptyView()
//            }

            ZStack {
                Color.black.ignoresSafeArea()
                drawStars()
                drawGround()
                drawPlatforms()
                drawCollectibles()
                drawPlayer()
                displayItems()
                drawControls()
            }
            .onAppear(perform: setupGame)
            .onDisappear(perform: cleanUpGame)
            .onReceive(Timer.publish(every: 1, on: .main, in: .default).autoconnect()) { _ in
                gameState.energyBar = max(gameState.energyBar - 1, 0)
            }
//            .navigationDestination(for: String.self) { value in
//                            if value == "NextLevelView" {
//                                NextLevelView(path: $path)
//                            }
//                        }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Game Setup
    private func setupGame() {
        gameState.loadProgress(player: player)  // Load progress when the level starts
        gameState.currentLevel = 1

        // Ensure player starts at a valid position within the level bounds
        if player.position.x >= 750 || player.position.x < 200 {
            player.position.x = 200 // Reset to starting position
        }

        let generated = GameHelper.generatePlatforms(platformXPositions: platformXPositions)
        platforms = generated.platforms
        collectibles = generated.collectibles
        stars = GameHelper.generateStars(count: 100)
        startGameLoop()
        
        print("Player position: \(player.position.x)")

    }
    
    private func cleanUpGame() {
        stopGameLoop()
        GameHelper.resetGameState(player: player, groundLevel: groundLevel, platforms: &platforms, collectibles: &collectibles, stars: &stars)
    }
    
    // MARK: - UI Components
    private func drawStars() -> some View {
        ForEach(stars.indices, id: \.self) { index in
            Circle()
                .fill(Color.white)
                .frame(width: 2, height: 2)
                .position(stars[index])
        }
    }
    
    private func drawGround() -> some View {
        Rectangle()
            .fill(Color.gray)
            .frame(width: 1400, height: 50)
            .position(x: 200, y: groundLevel + 25)
    }
    
    private func drawPlatforms() -> some View {
        ForEach(platforms.indices, id: \.self) { index in
            Rectangle()
                .fill(Color.gray)
                .frame(width: platforms[index].size.width, height: platforms[index].size.height)
                .position(platforms[index].position)
        }
    }
    
    private func drawCollectibles() -> some View {
        ForEach(collectibles.indices, id: \.self) { index in
            Circle()
                .fill(Color.yellow)
                .frame(width: 20, height: 20)
                .position(collectibles[index].position)
        }
    }
    
    private func drawPlayer() -> some View {
        Image(player.iconImage) // Use the iconImage from Player class
            .resizable()
            .frame(width: 100, height: 100)
            .position(player.position)
    }

    private func displayItems() -> some View {
        VStack {
            HStack {
                ForEach(itemManager.items, id: \.id) { item in
                    VStack {
                        Image(item.name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("\(item.amount)")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            Spacer()
        }
    }
    
    private func drawControls() -> some View {
        VStack {
            Spacer()
            HStack {
                controlButton("←", action: startMovingLeft, stopAction: stopMovingLeft, astronautState: PlayerConstants.astronautLeft)
                controlButton("→", action: startMovingRight, stopAction: stopMovingRight, astronautState: PlayerConstants.astronautRight)
                Spacer()
                Button(action: jump) {
                    Text("↑")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
    
    private func controlButton(_ title: String, action: @escaping () -> Void, stopAction: @escaping () -> Void, astronautState: String) -> some View {
        Button(action: {}) {
            Text(title)
                .font(.largeTitle)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
        }
        .simultaneousGesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in
                action()
                player.iconImage = astronautState // Update astronaut image from Player class
            }
            .onEnded { _ in
                stopAction()
                player.iconImage = PlayerConstants.astronautIdle // Set back to idle state
            })
    }
    
    // MARK: - Game Logic
    private func startMovingLeft() {
        player.startMovingLeft()
    }
    
    private func stopMovingLeft() {
        player.stopMovingLeft()
    }
    
    private func startMovingRight() {
        player.startMovingRight()
    }
    
    private func stopMovingRight() {
        player.stopMovingRight()
    }
    
    private func jump() {
        player.jump()
    }
    
    private func startGameLoop() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in updateGame() }
    }
    
    private func stopGameLoop() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    private func updateGame() {
        // Constants for physics
        let gravity: CGFloat = 100
        let maxFallSpeed: CGFloat = 300
        let playerWidth: CGFloat = 40 // Adjust to match the player's width
        let playerHeight: CGFloat = 40 // Adjust to match the player's height

        var velocity: CGFloat = 0
        var currentlyOnPlatform = false

        // Apply gravity and update position
        velocity += gravity * CGFloat(frameDuration)
        velocity = min(velocity, maxFallSpeed) // Cap fall speed
        player.position.y += velocity
        player.updatePosition(frameDuration: frameDuration)

        // Check if the player hits the ground
        if player.position.y >= groundLevel {
            player.position.y = groundLevel
            velocity = 0
            player.isJumping = false
            currentlyOnPlatform = true
        } else {
            // Check collision with platforms
            for platform in platforms {
                let platformTop = platform.position.y - platform.size.height / 2
                let platformBottom = platform.position.y + platform.size.height / 2
                let platformLeft = platform.position.x - 150 / 2 // Platform width is 150
                let platformRight = platform.position.x + 150 / 2

                let playerTop = player.position.y - playerHeight / 2
                let playerBottom = player.position.y + playerHeight / 2
                let playerLeft = player.position.x - playerWidth / 2
                let playerRight = player.position.x + playerWidth / 2

                // Check if the astronaut is within the horizontal bounds of the platform
                let withinPlatformBounds = playerLeft >= platformLeft && playerRight <= platformRight

                // Astronaut lands only when they are directly above the platform
                if velocity >= 0, // Falling down
                   withinPlatformBounds, // Horizontal bounds of the platform
                   playerBottom > platformTop, // Bottom is below the platform's top
                   playerTop < platformTop { // Top is above the platform's top
                    player.position.y = platformTop - playerHeight / 2 // Place player on top of the platform
                    velocity = 0
                    player.isJumping = false
                    currentlyOnPlatform = true
                    break
                }

                // Astronaut falls off if they are not within platform bounds
                if !withinPlatformBounds {
                    currentlyOnPlatform = false
                }
            }

            // Ensure the astronaut is falling if not on any platform
            if !currentlyOnPlatform {
                velocity += gravity * CGFloat(frameDuration)
            }
        }

        // Handle movement and collectibles
        handlePlayerMovement()
        handleCollectibles()

        // Check if the player has reached the level endpoint
        if player.position.x >= 750 {
//            path.removeLast(path.count)
//            path.append("NextLevelView")
            isSecondView = true
            endPoint = true
            gameState.savedPositions[gameState.currentLevel] = player.position
            gameState.saveProgress(player: player) // Save progress when level is completed
        }
    }





    
    private func handlePlayerMovement() {
        if player.isMovingLeft {
            player.moveLeft()
        }
        if player.isMovingRight {
            player.moveRight()
        }
    }
    
    private func handleCollectibles() {
        collectibles.removeAll { collectible in
            let collision = abs(player.position.x - collectible.position.x) < 20 &&
                            abs(player.position.y - collectible.position.y) < 20
            if collision { itemManager.addRandomItemAmount() }
            return collision
        }
    }
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        let gameState = GameState()  // Create an instance of GameState
        let player = Player(startPosition: CGPoint(x: 200, y: 300))  // Create an instance of Player
        
//        PlatformView(, isSecondView: isSec)
//            .environmentObject(gameState)  // Pass GameState to the view
//            .environmentObject(player)  // Pass Player to the view
    }
}

