//
//  ContentView.swift
//  WeatherGUI
//
//  Created by Axel Balestrieri on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var message: Text?
    var body: some View {
        VStack {
            if let location = locationManager.location{
                if let valWeather = weather {
                    Text("Weather data fetched! CHECK CONSOLE")
                } else {
                    LoadingView()
                        .task {
                            do {    
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error fetching weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading{
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(.purple)
        .preferredColorScheme(.dark)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
