//
//  Player.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 19/11/24.
//

import Foundation
class Player: ObservableObject {
    @Published var position: CGPoint
    @Published var velocity: CGFloat = 0
    @Published var isJumping: Bool = false
    @Published var isMovingLeft: Bool = false
    @Published var isMovingRight: Bool = false
    @Published var iconImage: String = PlayerConstants.astronautIdle
    @Published var isOnPlatform = false
    
    let groundLevel: CGFloat = 300
    let jumpStrength: CGFloat = -5
    let gravity: CGFloat = 2
    let speed: CGFloat = 10
    
    init(startPosition: CGPoint) {
        self.position = startPosition
    }
    
    func resetPosition() {
           position = CGPoint(x: 200, y: 300)
       }
    func moveLeft() {
        self.position.x -= speed
    }
    
    func moveRight() {
        self.position.x += speed
    }
    
    // changes here
    
    func jump() {
        if !isJumping && (self.position.y >= groundLevel || isOnPlatform) {
                    velocity = jumpStrength
                    isJumping = true
                    isOnPlatform = false
                }
    }
    
    func updatePosition(frameDuration: CGFloat) {
        if isJumping {
            velocity += gravity * frameDuration
            position.y += velocity
        }
        
        if position.y >= groundLevel {
            position.y = groundLevel
            velocity = 0
            isJumping = false
        }
    }
    
    func startMovingLeft() {
        isMovingLeft = true
        iconImage = PlayerConstants.astronautLeft
    }
    
    func stopMovingLeft() {
        isMovingLeft = false
        iconImage = PlayerConstants.astronautIdle
    }
    
    func startMovingRight() {
        isMovingRight = true
        iconImage = PlayerConstants.astronautRight
    }
    
    func stopMovingRight() {
        isMovingRight = false
        iconImage = PlayerConstants.astronautIdle
    }
    
    func checkCollectibleCollision(collectibles: [Collectible]) -> Collectible? {
        for collectible in collectibles {
            let distanceX = abs(position.x - collectible.position.x)
            let distanceY = abs(position.y - collectible.position.y)
            
            if distanceX < 20 && distanceY < 20 {
                return collectible
            }
        }
        return nil
    }
}

