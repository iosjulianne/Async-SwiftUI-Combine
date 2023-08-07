//
//  LocationManager.swift
//  AsyncSunrise
//
//  Created by Julianne on 8/5/23.
//

import AsyncLocationKit
import Combine
import CoreLocation

class LocationManager: ObservableObject {
    @Published var currentLocation: CLLocation? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    private let locationManager = AsyncLocationManager()

    func requestLocation() {

    }
}


