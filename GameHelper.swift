//
//  GameHelper.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 20/11/24.
//

import Foundation
import SwiftUI

class GameHelper {
    
    // MARK: - Game Setup
    static func generateCollectibles(count: Int, area: CGRect) -> [Collectible] {
        (0..<count).map { _ in
            let xPosition = CGFloat.random(in: area.minX...area.maxX)
            let yPosition = CGFloat.random(in: area.minY...area.maxY)
            // Use a default size (e.g., CGSize(width: 20, height: 20)) or define it as needed
            let size = CGSize(width: 20, height: 20)
            return Collectible(position: CGPoint(x: xPosition, y: yPosition), size: size)
        }
    }


    
    static func generatePlatforms(platformXPositions: [CGFloat]) -> (platforms: [Platform], collectibles: [Collectible]) {
        var platforms: [Platform] = []
        var collectibles: [Collectible] = []
        
        for xPosition in platformXPositions {
            let randomY = CGFloat.random(in: 150...250)
            let platform = Platform(position: CGPoint(x: xPosition, y: randomY), size: CGSize(width: 150, height: 20))
            platforms.append(platform)
            
            if Bool.random() {
                // Add size parameter to Collectible
                let collectibleSize = CGSize(width: 20, height: 20) // or any other size you prefer
                collectibles.append(Collectible(position: CGPoint(x: xPosition, y: randomY - 20), size: collectibleSize))
            }
        }
        
        return (platforms, collectibles)
    }

    
    static func generateStars(count: Int) -> [CGPoint] {
        return (0..<count).map { _ in
            CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
        }
    }
    
    static func resetGameState(player: Player, groundLevel: CGFloat, platforms: inout [Platform], collectibles: inout [Collectible], stars: inout [CGPoint]) {
        player.position = CGPoint(x: 200, y: groundLevel) // Reset player position
        platforms.removeAll()
        collectibles.removeAll()
        stars.removeAll()
        player.isJumping = false
        player.velocity = 0
        player.isMovingLeft = false
        player.isMovingRight = false
    }
    static func generateLunarFeatures(count: Int, type: LunarFeature.FeatureType, groundLevel: CGFloat) -> [LunarFeature] {
            (0..<count).map { _ in
                let xPosition = CGFloat.random(in: 50...750)
                let size = type == .crater ? CGFloat.random(in: 50...100) : CGFloat.random(in: 30...60)
                let yPosition = groundLevel - (type == .crater ? size / 2 : size)
                
                return LunarFeature(
                    position: CGPoint(x: xPosition, y: yPosition),
                    size: size,
                    type: type
                )
            }
        }
    static func generatePlatforms(platformXPositions: [CGFloat], groundLevel: CGFloat) -> (platforms: [Platform], collectibles: [Collectible]) {
        var platforms: [Platform] = []
        var collectibles: [Collectible] = []
        
        for xPosition in platformXPositions {
            let platform = Platform(position: CGPoint(x: xPosition, y: groundLevel - 50), size: CGSize(width: 150, height: 20))
            platforms.append(platform)
            
            // Assuming Collectible requires a size parameter:
            let collectibleSize = CGSize(width: 20, height: 20) // You can adjust the size as needed
            let collectible = Collectible(position: CGPoint(x: xPosition + 50, y: groundLevel - 100), size: collectibleSize)
            collectibles.append(collectible)
        }
        
        return (platforms, collectibles)
    }

    

}


