//
//  BuildingGridView.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 24/11/24.
//

import SwiftUI

struct BuildingGridView: View {
    @EnvironmentObject var buildingManager: BuildingManager
    
    
    
    var body: some View {
        GeometryReader{  geometry in
            let spacing = geometry.size.width * 0.2// Adjust multiplier for smaller spacing
                        
                        // Define columns with equal flexibility
            let columns = [GridItem(.fixed(CGFloat(spacing))), GridItem(.fixed(CGFloat(spacing))), GridItem(.fixed(CGFloat(spacing)))]
            LazyVGrid(columns: columns, spacing: geometry.size.width * 0.02) {
                ForEach(buildingManager.buildings) { building in
                    ZStack {
                        Rectangle()
                            .fill(Color(white: 0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 21.6))
                            .frame(width: geometry.size.width * 0.20, height: geometry.size.width * 0.20)
                        Image("\(building.imageName)")
                            .resizable()
                            .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
//
                    }
                }
            }
        }
    }
}

#Preview {
    BuildingGridView()
}
