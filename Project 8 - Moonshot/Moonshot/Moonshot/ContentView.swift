//
//  ContentView.swift
//  Moonshot
//
//  Created by J B on 03/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
//    let crewAstronauts: [CrewMember]
    
//    let missions: [Mission]
    
    
    @State private var showLaunchdate = true
    
    var body: some View {
        
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, missions: self.missions, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
//We change the format so that we have the user get the date in the format we wish from our JSON data
                        Text(self.showLaunchdate ? mission.formattedLaunchDate : self.crewMission(mission))
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(self.showLaunchdate ? "Show Launchdate" : "Show Crew Names") {
                    self.showLaunchdate.toggle()
            })
        }
        
    }
    
    func crewMission(_ mission: Mission) -> String {
        return mission.crew.map { $0.name }.joined(separator: ", ")
    }

}
    
struct ContentView_Previews: PreviewProvider {
//    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        ContentView()
    }
}
