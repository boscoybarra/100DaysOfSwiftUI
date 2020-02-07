//
//  Codable.swift
//  Milestone Projects 10-12
//
//  Created by J B on 01/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI





struct CodableTest: View {
    var body: some View {
        
        struct User: Codable {
            var firstName: String
            var lastName: String
        }
        
        let str = """
        {
            "first_name": "Andrew",
            "last_name": "Glouberman"
        }
        """

        let data = Data(str.utf8)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let user = try decoder.decode(User.self, from: data)
            print("Hi, I'm \(user.firstName) \(user.lastName)")
        } catch {
            print("Whoops: \(error.localizedDescription)")
        }
        
    }
}

struct Codable_Previews: PreviewProvider {
    static var previews: some View {
        CodableTest()
    }
}
