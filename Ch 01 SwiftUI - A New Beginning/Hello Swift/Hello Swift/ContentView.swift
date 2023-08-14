//
//  ContentView.swift
//  Hello Swift
//
//  Created by Julianne on 3/3/23.
//
/*
 Exercises:
 - Add a button to reset the name variable to an empty string.
 - When the name variable is empty, the greeting will read Hello, !, which looks a bit awkward. Using what you’ve learned in this chapter, can you try to think of a way to only show the comma if name contains at least one letter?
 */

import SwiftUI

struct ContentView: View {
    @State var name = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            // Add a button to reset the name variable to an empty string.
            Button("Reset") {
                name = ""
            }
            TextField("Enter Name Here", text: $name)
                .padding(.all)
                .border(Color.green, width: 1)
                .padding(.all)
            // Only show the comma if name contains at least one letter
            Text(name.containsALetter ? "Hello, \(name)!" : "Hello!")
                .font(.title)
                .foregroundColor(Color.purple)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String {
    var containsALetter: Bool {
        let letters = CharacterSet.letters
        return self.rangeOfCharacter(from: letters) != nil
    }
}
