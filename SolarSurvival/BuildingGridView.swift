//
//  BuildingGridView.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 24/11/24.
//

import SwiftUI

struct BuildingGridView: View {
    @EnvironmentObject var buildingManager: BuildingManager

    let columns = [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(buildingManager.buildings) { building in
                ZStack {
                    Rectangle()
                        .fill(Color(white: 0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 21.6))
                        .frame(width: 100, height: 100)
                    Image("\(building.imageName)")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
        }
    }
}

#Preview {
    BuildingGridView()
}
