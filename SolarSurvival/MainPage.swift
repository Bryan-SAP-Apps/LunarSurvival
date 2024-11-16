import SwiftUI
import SDWebImageSwiftUI

struct SwiftUIView: View {
    @State private var isNavigated = false
    @State private var isAnimated = true
    @State private var continuee = false
    @State private var start = "Start/Continue"
    
    var body: some View {
        NavigationStack {
            Color(red: 0.01, green: 0.1, blue: 0.4)
                .ignoresSafeArea()
                .overlay(
                    VStack{
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
                                            .padding(.trailing, 62.5)
                                            .padding(.leading, 62.5)
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
                                            .padding(.trailing, 55)
                                            .padding(.leading, 60)
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
                )
            
            // Programmatic NavigationLink
            NavigationLink(destination: GameMain(), isActive: $isNavigated) {
                EmptyView() // Use an empty view for the link
            }
        }
    }
    
    
    
}
#Preview{
    SwiftUIView()
}
