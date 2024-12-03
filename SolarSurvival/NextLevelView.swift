//
//  ContentView.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 21/11/24.
//

import SwiftUI

struct NextLevelView: View {
    @AppStorage("platform") var currentlyOnPlatform: Bool = false
    @State private var isRunning = false
    @State private var goHome = false
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var player: Player
    @State private var boulders: [LunarFeature] = []
    @State private var platforms: [Platform] = []
    @State private var collectibles: [Collectible] = []
    @State private var stars: [CGPoint] = []
    @State private var endPoint = false
    @State private var gameTimer: Timer? // Correctly define gameTimer here
    @State private var path = NavigationPath()
    @Binding var isSecondView: Bool
    @StateObject var energyManager = EnergyManager()
    private let groundLevel: CGFloat = 300
    private let frameDuration = 0.016
    private let platformXPositions: [CGFloat] = [150, 400, 650]
    
    @StateObject private var itemManager = ItemManager()

    var body: some View {
        NavigationStack(path: $path){
            NavigationLink(destination: HomePage(), isActive: $goHome){
                EmptyView()
            }
            ZStack {
                
                Color.black.ignoresSafeArea()
                GameUIHelper.drawLevelElements(
                    stars: stars,
                    platforms: platforms,
                    collectibles: collectibles,
                    boulders: boulders,
                    groundLevel: groundLevel
                )
//                drawPlatforms()
//                drawCollectibles()
                drawPlayer()
                displayItems()
                drawControls()
            }
            .onAppear(perform: {
                startDecrementing()
            })
            .onAppear(perform: setupGame
                      )
            .onDisappear(perform: cleanUpGame)
            .onDisappear(perform: {
                stopDecrementing()
            })
            

//            .navigationDestination(for: String.self) { value in
//                            if value == "NextLevelView" {
//                                NextLevelView(path: $path)
//                            }
//                        }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Game Setup
    func startDecrementing() {
        // Only start the decrementing process if it's not already running
        if !isRunning {
            isRunning = true
            DispatchQueue.global(qos: .background).async {
                while energyManager.energies[0].amount > 0 && isRunning {
                    DispatchQueue.main.async {
                        energyManager.energies[0].amount -= 0.25
                    }
                    Thread.sleep(forTimeInterval: 1) // Sleep for 1 second
                }
                DispatchQueue.main.async {
                    isRunning = false // Stop when the value reaches 0 or is manually stopped
                    if energyManager.energies[0].amount <= 0 {
                        goHome = true // Trigger navigation to home
                    }
                }
            }
        }
    }

        func stopDecrementing() {
            // Set isRunning to false to stop the decrementing process
            isRunning = false
        }
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
        boulders = GameHelper.generateLunarFeatures(count: 3, type: .boulder, groundLevel: groundLevel)
        startGameLoop()
        

    }
    
    private func cleanUpGame() {
        stopGameLoop()
        GameHelper.resetGameState(player: player, groundLevel: groundLevel, platforms: &platforms, collectibles: &collectibles, stars: &stars)
    }
    
    // MARK: - UI Components
    
    private func drawPlayer() -> some View {
        Image(player.iconImage) // Use the iconImage from Player class
            .resizable()
            .frame(width: 100, height: 100)
            .position(player.position)
    }

    private func displayItems() -> some View {
        VStack{
            HStack{
                HStack{
                    Button {
                        goHome = true

                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
                HStack {
                    ForEach(itemManager.items, id: \.id) { item in
                        VStack {
                            Image(item.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                            HStack {
//                                Text("\(item.amount)")
//                                    .font(.title3)
//                                    .foregroundColor(.white)
//                                    .padding()
                                Text("\(item.amount) ")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                    }

                }
                .padding()
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(Color(white: 0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 19))
                        .frame(width: 250, height: 50)
                    HStack{
                        let result = Double(energyManager.energies[0].amount) * 2
                        Image(systemName: "bolt.fill")
                        ZStack(alignment: .leading){
                            Rectangle()
                                .fill(Color(.white))
                                .frame(width: 200, height: 35)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                            Rectangle()
                                .fill(Color(.yellow))
                                .frame(width: CGFloat(result), height: 35)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                    }
                    
                }
            }
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
                // Check if the player is above the platform and within platform boundaries
                if abs(player.position.x - platform.position.x) < (20 + platform.size.width / 2) &&
                    abs(player.position.y - platform.position.y) < (20 + platform.size.height / 2) &&
                    velocity >= 0 { // Check if falling onto platform
                    player.position.y = platform.position.y - 20 // Place player on top of the platform
                    velocity = 0
                    player.isJumping = false
                    currentlyOnPlatform = true
                    break
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
        handleBoulderPush()
        updateBoulders()
        // Check if the player has reached the level endpoint
        if player.position.x >= 750 {
//            path.removeLast(path.count)
//            path.append("NextLevelView")
            isSecondView = false
            endPoint = true
            gameState.savedPositions[gameState.currentLevel] = player.position
            gameState.saveProgress(player: player) // Save progress when level is completed
        }
    }
    private func handleBoulderPush() {
        for boulder in boulders {
            let boulderBounds = CGRect(
                x: boulder.position.x - boulder.size / 2,
                y: boulder.position.y - boulder.size / 2,
                width: boulder.size,
                height: boulder.size
            )

            let playerBounds = CGRect(
                x: player.position.x - 100 / 2,
                y: player.position.y - 100 / 2,
                width: 100,
                height: 100
            )

            // Check if the player is on the ground level and horizontally aligned with the boulder
            if boulderBounds.intersects(playerBounds) && player.position.y >= groundLevel {
                // Push the player to the right or left, depending on their position relative to the boulder
                if player.position.x < boulder.position.x {
                    player.position.x -= 15 // Push to the left
                }
            }
        }
    }

    private func updateBoulders() {
        for i in boulders.indices {
            // Move the boulders left at a constant rate
            boulders[i].position.x -= 100 * CGFloat(frameDuration) // 100 is the boulder speed

            // Reset position if out of bounds
            if boulders[i].position.x < 0 {
                boulders[i].position.x = CGFloat.random(in: UIScreen.main.bounds.width...UIScreen.main.bounds.width + 500)
            }
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

