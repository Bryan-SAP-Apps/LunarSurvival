//
//  Alert.swift
//  SolarSurvival
//
//  Created by Bryan Nguyen on 28/11/24.
//

import SwiftUI

class AlertViewModel: ObservableObject {
    @Published var activeAlert: ActiveAlert = .none
}

enum ActiveAlert {
    case alert1, alert2, alert3, none
}
