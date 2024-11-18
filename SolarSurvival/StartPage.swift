import SwiftUI
import SDWebImageSwiftUI

struct StartView: View {
    @State private var isNavigated = false
    @State private var isAnimated = true
    @State private var continuee = false
    @State private var start = "Start/Continue"
    
    var playCutscene: () -> Void // Callback to play cutscene again
    
    var body: some View {
            ZStack {
                Color(red: 0.01, green: 0.1, blue: 0.4)
                    .ignoresSafeArea()
                VStack{
                
                    HStack{
                        ZStack{
                            
                            VStack {
                                
                                HStack{// Existing content of the view goes here
                                    
                                    Button(action: {
                                        playCutscene()
                                    }) {
                                        Text("Play Cutscene Again")
                                            .padding(.all, 10)
                                            .background(Color.blue)
                                            .foregroundStyle(.white)
                                            .font(.caption2)
                                    }
                                    
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .padding(.top, 40)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                        .background {
                            AnimatedImage(name:"Homepage.gif", isAnimating: $isAnimated)
                        }
                        VStack{
                            Text("Lunar")
                                .font(.system(size: 50))
                                .bold()
                                .foregroundStyle(.white)
                            Text("Survival")
                                .font(.system(size: 50))
                                .bold()
                                .foregroundStyle(.white)
                            VStack{
                                
                                // Button to navigate to the second view
                                Button(action: {
                                    isNavigated = true // Set the state to true to navigate
                                    if (continuee == false){
                                        start = "Start"
                                    } else {
                                        start = "Continue"
                                    }
                                }) {
                                    Text(start)
                                        .font(.title)
                                        .padding()
                                        .frame(width: 300)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    
                                }
                                
                                Button(action: {
                                    isNavigated = true // Set the state to true to navigate
                                    if (continuee == false){
                                        start = "Start"
                                    } else {
                                        start = "Continue"
                                    }
                                }) {
                                    Text("Reset")
                                        .font(.title)
                                        .padding()
                                        .frame(width: 300)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    
                                    
                                    
                                }
                            }
                        }
                        
                        
                    }
                    
                    
                    HStack{
                        
                        
                        //                            Spacer()
                        Spacer()
                        
                    }
                    
                }
                
            }
            
            
            // Programmatic NavigationLink
            NavigationLink(destination: GameMain(), isActive: $isNavigated) {
                EmptyView() // Use an empty view for the link
            }
        .navigationBarBackButtonHidden()
    }
    
    
    
}
#Preview{
    StartView(playCutscene: {
        print("Playing cutscene action again")
    })
}
