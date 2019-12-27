//
//  ContentView.swift
//  WordScramble
//
//  Created by Bosco on 24/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //we need an array of words they have already used
    @State private var usedWords = [String]()
    //a root word for them to spell other words from
    @State private var rootWord = ""
    //string we can bind to a text field
    @State private var newWord = ""
    //count the total words
    @State private var countWords = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
//Because the closure’s signature – the parameters it needs to accept and its return type – exactly matches the addNewWord() method we just wrote, we can pass that in directly onCommit:

//To read when return is pressed for a text view we should add an onCommit() modifier.
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Total Score")
                .font(.system(size: 20.0))
                
                Text("\(self.countWords)")
                    .font(.largeTitle)
                
            }
            // We can use onAppear() to run a closure when a view is shown.
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button(action: startGame) {
                Text("New Game")
            })
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .padding()
        
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }

        // extra validation
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word, the word is shorter that three characters or the same word as given!")
            return
        }
        
        guard score(word: answer) else {
            wordError(title: "No possible addition", message: "It was not possible to make any addition")
            return
        }
        
        

        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"

                // If we are here everything has worked, so we can exit and set counter to 0
                
                self.countWords = 0
                return
            }
        }

        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        if word.count > 3 && word != self.rootWord {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

            return misspelledRange.location == NSNotFound
        } else {
            return false
        }
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func score(word: String) -> Bool {
        if word.count > 0 {
            let count = word.count
            countWords += count
            return true
        } else {
            return false
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
