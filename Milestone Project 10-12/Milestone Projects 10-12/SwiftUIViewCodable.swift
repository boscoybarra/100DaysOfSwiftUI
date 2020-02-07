//
//  SwiftUIViewCodable.swift
//  Milestone Projects 10-12
//
//  Created by J B on 01/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI


// Step 1: TODO 1. Fetch the data and parse it into User and Friend structs.









struct SwiftUIViewCodable: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







//struct SwiftUIViewCodable: View {
//    var body: some View {
//
//        struct User: Codable {
//            var firstName: String
//            var lastName: String
//        }
//
//        let str = """
//        {
//            "first_name": "Andrew",
//            "last_name": "Glouberman"
//        }
//        """
//
//        let data = Data(str.utf8)
//
//        do {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//            let user = try decoder.decode(User.self, from: data)
//            print("Hi, I'm \(user.firstName) \(user.lastName)")
//        } catch {
//            print("Whoops: \(error.localizedDescription)")
//        }
//    }
//}
