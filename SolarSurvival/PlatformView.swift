import SwiftUI

struct PlatformView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var player: Player

    @State private var platforms: [Platform] = []
    @State private var collectibles: [Collectible] = []
    @State private var stars: [CGPoint] = []
    @State private var craters: [LunarFeature] = []
    @State private var boulders: [LunarFeature] = []
    @State private var endPoint = false
    @State private var gameTimer: Timer?
    @State private var path = NavigationPath()
    @Binding var isSecondView: Bool

    private let groundLevel: CGFloat = 300
    private let frameDuration = 0.016
    private let platformXPositions: [CGFloat] = [150, 400, 650]
    
    @StateObject private var itemManager = ItemManager()
    @StateObject private var levelManager = LevelManager()

    // MARK: - UI Components
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.black.ignoresSafeArea()
                GameUIHelper.drawLevelElements(
                    stars: stars,
                    platforms: platforms,
                    collectibles: collectibles,
                    craters: craters,
                    boulders: boulders,
                    groundLevel: groundLevel
                )
                drawPlayer()
                displayScoreAndInventory()
                drawControls()
            }
            .onAppear(perform: setupGame)
            .onDisappear(perform: cleanUpGame)
            .onReceive(Timer.publish(every: 1, on: .main, in: .default).autoconnect()) { _ in
                gameState.energyBar = max(gameState.energyBar - 1, 0)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Game Setup and Cleanup
    private func setupGame() {
        gameState.loadProgress(player: player)
        gameState.currentLevel = 1

        let generated = GameHelper.generatePlatforms(platformXPositions: platformXPositions, groundLevel: groundLevel)
        platforms = generated.platforms
        collectibles = generated.collectibles
        stars = GameHelper.generateStars(count: 100)
        craters = GameHelper.generateLunarFeatures(count: 5, type: .crater, groundLevel: groundLevel)
        boulders = GameHelper.generateLunarFeatures(count: 3, type: .boulder, groundLevel: groundLevel)

        startGameLoop()
    }

    private func cleanUpGame() {
        stopGameLoop()
        GameHelper.resetGameState(player: player, groundLevel: groundLevel, platforms: &platforms, collectibles: &collectibles, stars: &stars)
    }

    // MARK: - Drawing Methods
    private func drawPlayer() -> some View {
        Image(player.iconImage)
            .resizable()
            .frame(width: 100, height: 100)
            .position(player.position)
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
                player.iconImage = astronautState
            }
            .onEnded { _ in
                stopAction()
                player.iconImage = PlayerConstants.astronautIdle
            })
    }

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

    // MARK: - Game Loop
    private func startGameLoop() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            updateGame()
        }
    }

    private func stopGameLoop() {
        gameTimer?.invalidate()
        gameTimer = nil
    }

    private func updateGame() {
        let gravity: CGFloat = 100
        let maxFallSpeed: CGFloat = 300
        let playerWidth: CGFloat = 40
        let playerHeight: CGFloat = 40

        var velocity: CGFloat = 0
        var currentlyOnPlatform = false

        velocity += gravity * CGFloat(frameDuration)
        velocity = min(velocity, maxFallSpeed)
        player.position.y += velocity
        player.updatePosition(frameDuration: frameDuration)

        if player.position.y >= groundLevel {
            player.position.y = groundLevel
            velocity = 0
            player.isJumping = false
            currentlyOnPlatform = true
        } else {
            for platform in platforms {
                let platformTop = platform.position.y - platform.size.height / 2
                let withinPlatformBounds = player.position.x >= platform.position.x - 75 && player.position.x <= platform.position.x + 75

                if velocity >= 0 && withinPlatformBounds && player.position.y + playerHeight / 2 > platformTop {
                    player.position.y = platformTop - playerHeight / 2
                    velocity = 0
                    player.isJumping = false
                    currentlyOnPlatform = true
                    break
                }
            }
            if !currentlyOnPlatform {
                velocity += gravity * CGFloat(frameDuration)
            }
        }

        handlePlayerMovement()
        handleCollectibles()

        if player.position.x >= 750 {
            isSecondView = true
            endPoint = true
            gameState.savedPositions[gameState.currentLevel] = player.position
            gameState.saveProgress(player: player)
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
            let collision = abs(player.position.x - collectible.position.x) < collectible.size.width / 2 &&
                            abs(player.position.y - collectible.position.y) < collectible.size.height / 2
            if collision {
                gameState.score += 10
                itemManager.addRandomItemAmount()
            }
            return collision
        }
    }


    // MARK: - Player Actions
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
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        let gameState = GameState()
        let player = Player(startPosition: CGPoint(x: 200, y: 300))
        PlatformView(isSecondView: .constant(false))
            .environmentObject(gameState)
            .environmentObject(player)
    }
}
