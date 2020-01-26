//
//  ContentView.swift
//  Bookworm
//
//  Created by J B on 21/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI


struct ContentView: View {

//   That gives us a managed object context we can pass into AddBookView, a fetch request reading all the books we have (so we can test everything worked), and a Boolean that tracks whether the add screen is showing or not.
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
//  You can specify more than one sort descriptor, and they will be applied in the order you provide them. For example, if the user added the book “Forever” by Pete Hamill, then added “Forever” by Judy Blume – an entirely different book that just happens to have the same title – then specifying a second sort field is helpful.
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    
        var body: some View {
             NavigationView {
                List {
                    ForEach(books, id: \.self) { book in
                        NavigationLink(destination: DetailView(book: book)) {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? Color.red : Color.black)
                                Text("\(book.author!) - posted \(self.formattedDate(date: book.date))")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                .onDelete(perform: deleteBooks)
                }
                    .navigationBarTitle("Bookworm")
                    .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                        self.showingAddScreen.toggle()
                    }) {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingAddScreen) {
                        AddBookView().environment(\.managedObjectContext, self.moc)
                    }
            }
    }
            
            func deleteBooks(at offsets: IndexSet) {
                for offset in offsets {
                    // find this book in our fetch request
                    let book = books[offset]

                    // delete it from the context
                    moc.delete(book)
                }

                // save the context
                try? moc.save()
            }
    
    func formattedDate(date: Date?) -> String {
        if let date = date {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: date)
        } else {
            return "N/A"
        }
    }

        }
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
