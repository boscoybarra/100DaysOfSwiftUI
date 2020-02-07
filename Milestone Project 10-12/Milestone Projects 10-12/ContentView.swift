//
//  ContentView.swift
//  Milestone Projects 10-12
//
//  Created by J B on 05/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI
import Foundation


//// Step 1: TODO 1. Fetch the data and parse it into User and Friend structs.


struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
        List(users, id: \.id) { user in
            NavigationLink(destination: UserView(user: user, users: self.users)) {
               HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 20.0, height: 20.0)
                        .foregroundColor(user.isActive ? .green : .red)
                    Text(user.name)
                    Text("(\(user.friends.count) friends)")
                
                }.padding(5)
            }
        }
        //      We want that to be run as soon as our List is shown, so you should add this modifier to the List:
            .navigationBarTitle("Friends")
    }
    .onAppear(perform: loadData)
}

    
func loadData() {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
        print("Invalid URL")
        return
    }

    let request = URLRequest(url:url)

    URLSession.shared.dataTask(with: request) { data, response, error in
//1. data is whatever data was returned from the request.
//2. response is a description of the data, which might include what type of data it is, how much was sent,               whether there was a status code, and more.
//3. error is the error that occurred.
        if let data = data {
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                // we have good data – go back to the main thread
                DispatchQueue.main.async {
                    // update our UI
                    self.users = decodedResponse
                }
                // everything is good, so we can exit
                return
            }
        }

        // if we're still here it means there was a problem
        print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    }.resume()
// But with it the request starts immediately, and control gets handed over to the system – it will automatically run in the background
    }
}

 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
