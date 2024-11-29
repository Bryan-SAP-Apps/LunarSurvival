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
struct AlertData: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var message: String
}


class AlertManager: ObservableObject {
    @AppStorage("alertTitle") var alertTitle: String = ""
    @AppStorage("alertMessage") var alertMessage: String = ""

    @Published var isAlertPresented: Bool = false

    func triggerAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isAlertPresented = true
    }

    func resetAlert() {
        isAlertPresented = false
        alertTitle = ""
        alertMessage = ""
    }
}
