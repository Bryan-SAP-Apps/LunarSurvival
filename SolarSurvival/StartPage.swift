import SwiftUI
import SDWebImageSwiftUI

struct StartView: View {
    @State private var isNavigated = false
    @State private var isAnimated = true
    @State private var continuee = false
    @State private var start = "Start/Continue"
    
    let playCutscene: () -> Void // Callback to play cutscene again
    
    var body: some View {
        NavigationStack {
            Color(red: 0.01, green: 0.1, blue: 0.4)
                .ignoresSafeArea()
                .overlay(
                    
                    VStack{
                        
                        VStack{
                            HStack{// Existing content of the view goes here
                                
                                Button(action: {
                                    playCutscene()
                                }){Text("Play Cutscene Again")
                                }
                                .padding()
                                .foregroundStyle(.white)
                                .background(Color.blue)
                                Spacer()
                                
                            }
                            Spacer()
                        }
                        HStack{
                            AnimatedImage(name:"Homepage.gif", isAnimating: $isAnimated)
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
                                            .frame(width: 250)
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
                                            .frame(width: 250)                                            .background(Color.red)
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
                )
            
            // Programmatic NavigationLink
            NavigationLink(destination: GameMain(), isActive: $isNavigated) {
                EmptyView() // Use an empty view for the link
            }
        }
    }
    
    
    
}
#Preview{
    StartView(playCutscene: {
        print("Playing cutscene action again")
    })
}
