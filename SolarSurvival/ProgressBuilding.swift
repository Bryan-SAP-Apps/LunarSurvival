import SwiftUI

struct ProgressBuilding: View {
    @State private var downloadAmount = 0.0
    @State private var pressFromLeft = false
    @State private var pressFromRight = false
    
    var body: some View {
        VStack {
            Text("Press both buttons at the same time to build the infrastructure")
            HStack {
                Button {
                    pressFromRight = true
                    checkSimultaneousPress()
                } label: {
                    Text("press me")
                }
                
                ProgressView("Building…", value: downloadAmount, total: 100)
                
                Button {
                    pressFromLeft = true
                    checkSimultaneousPress()
                } label: {
                    Text("press me")
                }
            }
        }
    }
    
    private func checkSimultaneousPress() {
        // Check if both buttons have been pressed within a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if pressFromLeft && pressFromRight {
                downloadAmount += 5
                pressFromLeft = false
                pressFromRight = false
            } else {
                // Reset if only one button was pressed
                pressFromLeft = false
                pressFromRight = false
            }
        }
    }
}

#Preview {
    ProgressBuilding()
}
