//
//  PlatformHolder.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 21/11/24.
//

import SwiftUI

struct PlatformHolder: View {
    @State private var isSecondView = false

       
       var body: some View {
           if isSecondView {
               NextLevelView(isSecondView: $isSecondView)
           } else {
               PlatformView(isSecondView: $isSecondView)
           }
       }
}

#Preview {
    PlatformHolder()
}
