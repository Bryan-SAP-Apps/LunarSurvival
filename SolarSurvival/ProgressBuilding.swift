import SwiftUI
import SDWebImageSwiftUI

struct ProgressBuilding: View {
    @State var isAnimated = true
    @State private var downloadAmount = 0.0
    @State private var pressFromLeft = false
    @State private var pressFromRight = false
    @State private var timeRemaining = 10.0 // Placeholder for the timer
    @State private var isTimerRunning = true
    @State private var showTooSlowPopup = false
    @State private var showSuccessPopup = false
    @State private var retryCount = 0
    @State private var retryPenalty = 100
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            VStack {
                // Placeholder Text
                Text("Time Remaining: \(Int(timeRemaining))s")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                Text("Tap fast on both areas\nto build the base")
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.all, 3)
                
                
                
                
                HStack {
                    // Left Button
                    Button {
                        if !showSuccessPopup && !showTooSlowPopup {
                            pressFromLeft = true
                            checkSimultaneousPress()
                        }
                    } label: {
                        Text("CLICK\nME")
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 250)
                            .background(Color.green)
                            .cornerRadius(50)
                            .shadow(radius: 10)
                    }
                    
                    Spacer()
                    
                    // Right Button
                    Button {
                        if !showSuccessPopup && !showTooSlowPopup {
                            pressFromRight = true
                            checkSimultaneousPress()
                        }
                    } label: {
                        Text("CLICK\nME")
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 250)
                            .background(Color.green)
                            .cornerRadius(50)
                            .shadow(radius: 10)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                
                
                // Progress Bar
                VStack {
                    ProgressView(value: downloadAmount, total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: .black))
                        .scaleEffect(x: 1, y: 4, anchor: .center)
                        .padding(.horizontal, 20)
                    
                    Text("Building…")
                        .font(.footnote)
                        .foregroundColor(.black)
                        .padding(.top, 4)
                }
                .padding(.bottom, 20)
            }
            .background() {
                Image("moon surface img")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
            VStack{
                AnimatedImage(name: "Astro building", isAnimating: $isAnimated)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 60)
            }
            
            HStack {
                Spacer()
                VStack{// Existing content of the view goes here
                    
                    Text("Energy Left: \(retryPenalty)")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding(.top, 40)
                        .padding(.trailing, 30)
                    Spacer()
                }
            }
            
            if showTooSlowPopup {
                VStack {
                    Text("You are too slow!")
                        .font(.headline)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button("Try Again") {
                        retryCount += 1
                        retryPenalty -= 10 // Decrease penalty
                        restartTimer()
                        showTooSlowPopup = false
                    }
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
                .frame(width: 200, height: 150)
                .background(Color.black.opacity(0.75))
                .cornerRadius(20)
                .shadow(radius: 10)
            }
            
            if showSuccessPopup {
                VStack {
                    Text("Build Succeeded!")
                        .font(.headline)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    NavigationLink(destination: GameMain()) {
                        Text("Go Back")
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 200, height: 150)
                .background(Color.black.opacity(0.75))
                .cornerRadius(20)
                .shadow(radius: 10)
            }
        }
        .onAppear(perform: startTimer)
        .onDisappear {
            timer?.invalidate() // Stop the timer when the view disappears
        }
        
    }
    
    
    
    private func startTimer() {
        // Reset time and start timer
        timeRemaining = 10.0
        isTimerRunning = true
        timer?.invalidate() // Invalidate any previous timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                isTimerRunning = false
                if downloadAmount < 100 {
                    showTooSlowPopup = true
                }
            }
        }
    }
    
    private func restartTimer() {
        downloadAmount = max(downloadAmount, 0) // Keep progress
        startTimer() // Restart the timer
    }
    
    private func checkSimultaneousPress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if pressFromLeft && pressFromRight {
                if downloadAmount < 100 {
                    downloadAmount += 5
                }
                pressFromLeft = false
                pressFromRight = false
                
                if downloadAmount >= 100 {
                    timer?.invalidate() // Stop timer when progress is full
                    isTimerRunning = false
                    showSuccessPopup = true
                }
            } else {
                pressFromLeft = false
                pressFromRight = false
            }
        }
    }
}


#Preview {
    ProgressBuilding()
}
