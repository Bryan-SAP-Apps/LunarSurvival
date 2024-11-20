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
    static func generatePlatforms(platformXPositions: [CGFloat]) -> (platforms: [Platform], collectibles: [Collectible]) {
        var platforms: [Platform] = []
        var collectibles: [Collectible] = []
        
        for xPosition in platformXPositions {
            let randomY = CGFloat.random(in: 150...250)
            let platform = Platform(position: CGPoint(x: xPosition, y: randomY), size: CGSize(width: 150, height: 20))
            platforms.append(platform)
            if Bool.random() {
                collectibles.append(Collectible(position: CGPoint(x: xPosition, y: randomY - 20)))
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
}


