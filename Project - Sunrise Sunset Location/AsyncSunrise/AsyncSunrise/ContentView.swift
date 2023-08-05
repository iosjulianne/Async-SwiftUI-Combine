//
//  ContentView.swift
//  AsyncSunrise
//
//  Created by Julianne on 7/24/23.
//

import SwiftUI
import Combine
import Foundation

struct ContentView: View {
    
    @State var sunrise: String = ""
    @State var sunset: String = ""
    
    // Store the cancellable in a property
    @State var cancellable: AnyCancellable?
    
    let nyc = "lat=40.7128&lng=-74.0060"
    let tokyo = "lat=35.6762&lng=139.6503"
    let maui = "lat=20.7984&lng=-156.3319"
  
    var body: some View {
        VStack {
            Text("Sunrise: \(sunrise)")
            Text("Sunset: \(sunset)")
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Button("Fetch Sunrise and Sunset") {
                // Cancel the previous request if there is one
                cancellable?.cancel()
                
                // Call the fetchSunriseSunsetData function
                cancellable = fetchSunriseSunsetData()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }, receiveValue: { response in
                        // Update the UI with the received data
                        sunrise = response.results.sunrise
                        sunset = response.results.sunset
                    })
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

