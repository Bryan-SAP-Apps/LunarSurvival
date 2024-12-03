import SwiftUI

struct AstronautHandbookView: View {
    @State private var selectedSection: String? // To programmatically scroll
    
    var body: some View {
        ScrollViewReader { proxy in
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    // Navigation Buttons
                    
                    HStack {
                        VStack{
                            Text("The Astronaut’s Handbook")
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top)
                            Text("Essential Guidance for Survival in Space")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                        Menu {
                            Button("Oxygen Supply") {
                                proxy.scrollTo("oxygenSupply", anchor: .top)
                            }
                            Button("Shelter Construction") {
                                proxy.scrollTo("shelterConstruction", anchor: .top)
                            }
                            Button("Power Supply") {
                                proxy.scrollTo("powerSupply", anchor: .top)
                            }
                            Button("Life Support Systems") {
                                proxy.scrollTo("lifeSupportSystems", anchor: .top)
                            }
                            Button("SOS Communication") {
                                proxy.scrollTo("sosCommunication", anchor: .top)
                            }
                            Button("Note") {
                                proxy.scrollTo("note", anchor: .top)
                            }
                        } label: {
                            Label("Jump to Section", systemImage: "list.bullet")
                        }
                        .padding()
                    }
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            
                            Divider()
                            
                            // Chapter Section
                            Text("Chapter 1: The Moon – Survival Strategies and Past Lessons")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Divider()
                            
                            // Description
                            Text("""
                            With the Moon's extreme temperatures, its unpredictable environment, and the rocket's limited supplies, astronauts must act swiftly to ensure their survival.
                            """)
                            .font(.body)
                            
                            // Emergency Protocol Section
                            Text("Emergency Protocol: Forced Landing on the Moon")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            // Protocol Details
                            Group {
                                Text("Oxygen Supply:")
                                    .font(.headline)
                                    .id("oxygenSupply") // ID for navigation
                                Text("The spaceship contains only a 7-day oxygen reserve.")
                                    .font(.body)
                                
                                Text("Shelter Construction:")
                                    .font(.headline)
                                    .id("shelterConstruction") // ID for navigation
                                Text("""
                                Construct a basic shelter using all the materials available in the rocket's storage, including insulation materials. 
                                Glass may be used optionally in the construction.
                                Gather moon regolith on Day 1 for additional insulation to endure the Moon’s temperatures.
                                """)
                                .font(.body)
                                
                                Text("Power Supply:")
                                    .font(.headline)
                                    .id("powerSupply") // ID for navigation
                                Text("""
                                Stored electronics only have limited amounts of electricity. 
                                Deploy solar panels to generate additional power.
                                """)
                                .font(.body)
                                
                                Text("Life Support Systems:")
                                    .font(.headline)
                                    .id("lifeSupportSystems") // ID for navigation
                                Text("""
                                Prioritize building a CO2 filter to prevent carbon dioxide poisoning by the second day.
                                Assemble the water filter by the third day to ensure access to uncontaminated water.
                                """)
                                .font(.body)
                                
                                Text("SOS Communication:")
                                    .font(.headline)
                                    .id("sosCommunication") // ID for navigation
                                Text("""
                                Construct a high-gain antenna immediately to establish a communication link with Earth. The rescue team will require 3 days to reach you once contacted.
                                """)
                                .font(.body)
                            }
                            
                            Divider()
                            
                            // Note Section
                            Text("Note:")
                                .font(.headline)
                                .id("note") // ID for navigation
                            
                            Text("""
                            All materials can be found in rocket storage or from past missions.
                            
                            The Moon’s surface is littered with remnants of earlier expeditions, including spare parts and materials from past missions. These could be repurposed in emergencies.
                            
                            However, the Moon's surface is scattered with rolling boulders, which can pose significant dangers to astronauts.
                            
                            In situations like these, quick thinking, planning, and efficient use of resources are essential.
                            """)
                            .font(.body)
                        }
                        .padding()
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct AstronautHandbookView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautHandbookView()
    }
}
