//
//  LocationFetcher.swift
//  FaceLibrary
//
//  Created by Vivien on 5/3/23.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
