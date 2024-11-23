import SwiftUI
import Foundation

// Extension for documents directory
extension URL {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}



// Platform
struct Platform {
    var position: CGPoint
    var size: CGSize
}

// Collectible model
struct Collectible {
    var position: CGPoint
    var size: CGSize // Add size property
}


struct LunarFeature {
    enum FeatureType {
        case crater
        case boulder
    }
    
    var position: CGPoint
    var size: CGFloat
    var type: FeatureType
    var isRolling: Bool = false  // New state for rolling boulders
}

