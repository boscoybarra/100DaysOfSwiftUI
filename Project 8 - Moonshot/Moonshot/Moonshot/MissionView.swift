//
//  MissionView.swift
//  Moonshot
//
//  Created by Bosco on 06/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI


struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let missions: [Mission]
    let astronauts: [CrewMember]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    
                    Text(self.mission.formattedLaunchDate)
                        .padding()

                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, crewMissions: self.missions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, missions: [Mission], astronauts: [Astronaut]) {
        self.mission = mission
        self.missions = missions

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }
}


struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
//    As soon as that code is in, our preview struct will stop working again because it needs more information. So, add a second call to decode() there so it loads all the astronauts, then passes those in too:
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], missions: missions, astronauts: astronauts)
    }
}
