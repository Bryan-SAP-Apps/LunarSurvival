//
//  LevelManager.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 21/11/24.
//

import Foundation
struct Level {
    let platforms: [Platform]
    let collectibles: [Collectible]
    let stars: [CGPoint]
    let craters: [LunarFeature]
    let boulders: [LunarFeature]
    let endpoint: CGPoint
}

class LevelManager: ObservableObject {
    @Published var levels: [Level] = []
    
    init() {
        generateLevels()
    }
    
    private func generateLevels() {
        
        levels = [
            Level(
                platforms: GameHelper.generatePlatforms(platformXPositions: [100, 300, 500], groundLevel: 300).platforms,
                collectibles: GameHelper.generateCollectibles(
                    count: 5,
                    area: CGRect(x: 50, y: 100, width: 700, height: 200)
                ),
                stars: GameHelper.generateStars(count: 100),
                craters: GameHelper.generateLunarFeatures(count: 4, type: .crater, groundLevel: 300),
                boulders: GameHelper.generateLunarFeatures(count: 3, type: .boulder, groundLevel: 300),
                endpoint: CGPoint(x: 750, y: 300)
            ),
            // Add more levels as needed
        ]
    }
}
