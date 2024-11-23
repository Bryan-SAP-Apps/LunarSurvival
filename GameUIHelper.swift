import Foundation
import SwiftUI

class GameUIHelper {

    // Method to draw stars
    static func drawStars(stars: [CGPoint]) -> some View {
        ForEach(stars.indices, id: \.self) { index in
            Circle()
                .fill(Color.white)
                .frame(width: 2, height: 2)
                .position(stars[index])
        }
    }

    // Method to draw lunar dust
    static func drawLunarDust(groundLevel: CGFloat) -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.9))
            .frame(width: 1400, height: 50)
            .position(x: 700, y: groundLevel + 25)
    }

    // Method to draw craters
    static func drawCraters(craters: [LunarFeature]) -> some View {
        ForEach(craters.indices, id: \.self) { index in
            Circle()
                .fill(Color.gray.opacity(0.8))
                .frame(width: craters[index].size, height: craters[index].size)
                .position(craters[index].position)
        }
    }

    // Method to draw boulders
    static func drawBoulders(boulders: [LunarFeature]) -> some View {
        ForEach(boulders.indices, id: \.self) { index in
            Circle()
                .fill(Color.brown)
                .frame(width: boulders[index].size, height: boulders[index].size)
                .position(boulders[index].position)
        }
    }

    // Method to draw platforms
    static func drawPlatforms(platforms: [Platform]) -> some View {
        ForEach(platforms.indices, id: \.self) { index in
            Rectangle()
                .fill(Color.gray)
                .frame(width: platforms[index].size.width, height: platforms[index].size.height)
                .position(platforms[index].position)
        }
    }

    // Method to draw collectibles
    static func drawCollectibles(collectibles: [Collectible]) -> some View {
        ForEach(collectibles.indices, id: \.self) { index in
            Circle()
                .fill(Color.yellow)
                .frame(width: 20, height: 20)
                .position(collectibles[index].position)
        }
    }

    // Method to draw all level elements at once
    static func drawLevelElements(
        stars: [CGPoint],
        platforms: [Platform],
        collectibles: [Collectible],
        craters: [LunarFeature],
        boulders: [LunarFeature],
        groundLevel: CGFloat
    ) -> some View {
        Group {
            drawStars(stars: stars)
            drawLunarDust(groundLevel: groundLevel)
            drawCraters(craters: craters)
            drawBoulders(boulders: boulders)
            drawPlatforms(platforms: platforms)
            drawCollectibles(collectibles: collectibles)
        }
    }
}
