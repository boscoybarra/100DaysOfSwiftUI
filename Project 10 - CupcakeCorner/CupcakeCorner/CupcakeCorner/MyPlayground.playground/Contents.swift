import UIKit

var str = "Hello, playground"


//Adding Codable conformance for @Published properties


class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Bosco Ybarra"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}


//Sending and receiving Codable data with URLSession and SwiftUI


struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
//      We want that to be run as soon as our List is shown, so you should add this modifier to the List:
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url:url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            1. data is whatever data was returned from the request.
//            2. response is a description of the data, which might include what type of data it is, how much was sent,               whether there was a status code, and more.
//            3. error is the error that occurred.
            // step 4
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse.results
                    }

                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
//              But with it the request starts immediately, and control gets handed over to the system – it will                     automatically run in the background
    }
}


//Validating and disabling forms

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
//  We could also handle the condition adding a computed property like this:
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
//          .disabled(username.isEmpty || email.isEmpty)
            .disabled(disableForm)
        }
    }
}
