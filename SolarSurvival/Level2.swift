//
//  SwiftUIView.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 7/11/24.
//

import SwiftUI

struct NextLevelView: View {
//    @AppStorage("hhh") var level1x = 50
//    @AppStorage("hhh") var goLevel1 = false
    @StateObject private var gameState = GameState()
    @State private var isJumping = false
    @State private var gravity = CGFloat(50)
    @State private var velocity = CGFloat(0)
    @State private var score = 0
    @State private var isMovingLeft = false
    @State private var isMovingRight = false
    @State private var isOnPlatform = false
    @State private var endPoint = false
//    @State private var currentlyOnPlatform = true// Track if player is on a platform

    // Define platforms
    @State private var platforms: [Platform] = [
        Platform(position: CGPoint(x: 200, y: 250), size: CGSize(width: 150, height: 20)),
        Platform(position: CGPoint(x: 400, y: 200), size: CGSize(width: 150, height: 20)),
        Platform(position: CGPoint(x: 600, y: 150), size: CGSize(width: 150, height: 20)),
    ]
    
    @State private var collectibles: [Collectible] = [
        Collectible(position: CGPoint(x: 220, y: 230)),
        Collectible(position: CGPoint(x: 420, y: 180)),
        Collectible(position: CGPoint(x: 620, y: 130)),
    ]
        
    let groundLevel: CGFloat = 300
    let jumpStrength: CGFloat = -15
    let frameDuration = 0.016

    var body: some View {
        NavigationStack{
                NavigationLink(destination: ContentView(), isActive: $endPoint){
                    
                    EmptyView()
                }.onAppear {
                    // Set current level to 2 and adjust player position for this level
                    gameState.currentLevel = 2
                    gameState.playerPosition = CGPoint(x: 51, y: 300) // New start position in this level
                }
            
            ZStack {
                // Background
                Color.orange.ignoresSafeArea()
                
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
                
                // Collectibles
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
                        
                        Spacer()
                        
                        Button(action: {print(gameState.playerPosition.x) }) {
                            Text("→")
                                .font(.largeTitle)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        }
                        .simultaneousGesture(DragGesture(minimumDistance: 0)
                            .onChanged { _ in startMovingRight() }
                            .onEnded { _ in stopMovingRight() })
                    }
                    Button(action: { jump()
                        print(isJumping)}) {
                            Text("↑")
                                .font(.largeTitle)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        }
                }
                .padding()
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
        if gameState.playerPosition.x <= 50 { // Condition to trigger navigation
                   endPoint = true
            gameState.playerPosition = CGPoint(x: 750, y: 300)
                    
               }
//        if goLevel1 == true{
//            level1x = 700
//        }
        
        // Apply gravity and update player's position
        if isJumping {
            velocity += gravity * frameDuration
            gameState.playerPosition.y += velocity
        }

        // Reset `isOnPlatform` to check each frame if player is on a platform
        var currentlyOnPlatform = false

        // Check if player has landed on the ground
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
            // Check for landing on platforms
            for platform in platforms {
                // Check if the player is above the platform and within platform boundaries
                if abs(gameState.playerPosition.x - platform.position.x) < (20 + platform.size.width / 2) &&
                    abs(gameState.playerPosition.y - platform.position.y) < (20 + platform.size.height / 2) &&
                    velocity >= 0 { // Check if falling onto platform
                    gameState.playerPosition.y = platform.position.y - 20 // Place player on top of the platform
                    velocity = 0
                    isJumping = false
                    currentlyOnPlatform = true
                    break
                }
            }
        }

        // Update `isOnPlatform` based on whether the player is on any platform or the ground
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
    }

    func jump() {
        // Only allow jumping if the player is either on the ground or on a platform
        if !isJumping && (gameState.playerPosition.y >= groundLevel || isOnPlatform) {
            velocity = jumpStrength
            isJumping = true
            isOnPlatform = false // Set to false so gravity takes over after the jump
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

// Platform model
#Preview {
    NextLevelView()
}
