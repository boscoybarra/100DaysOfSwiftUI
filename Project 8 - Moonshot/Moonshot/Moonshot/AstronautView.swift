//
//  AstronautView.swift
//  Moonshot
//
//  Created by Bosco on 06/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    let crewMissions: [Mission]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text("Missions")
                        .font(.headline)
                        .padding()
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(self.crewMissions) { mission in
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                    
                                    Text(mission.displayName)
                                }
                            }
                        }
                        .padding()
                    }

                    Text(self.astronaut.description)
                        .padding()
//  Layout priority lets us control how readily a view shrinks when space is limited, or expands when space is plentiful. All views have a layout priority of 0 by default, which means they each get equal chance to grow or shrink. We’re going to give our astronaut description a layout priority of 1, which is higher than the image’s 0, which means it will automatically take up all available space.
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, crewMissions: [Mission]) {
        self.astronaut = astronaut
        
        var missionsIn = [Mission]()
        
        for mission in crewMissions {
            for crewRole in mission.crew {
                if crewRole.name == astronaut.id {
                    missionsIn.append(mission)
                }
            }
        }
        
        self.crewMissions = missionsIn
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0], crewMissions: missions)
    }
}
