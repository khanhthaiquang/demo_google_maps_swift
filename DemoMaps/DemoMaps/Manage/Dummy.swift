//
//  Dummy.swift
//  DemoMaps
//
//  Created by Khánh's Mac on 3/9/20.
//  Copyright © 2020 Khánh's Mac. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class DummyData: NSObject {
    static let share: DummyData = {
        let instance = DummyData()
        return instance
    }()
    
    func createListMarker() -> [GMSMarker]{
        var markers = [GMSMarker]()
        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 10.802928, longitude: 106.65258)))
        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 10.8090954, longitude: 106.613144)))
        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 21.023056, longitude: 105.819969)))
//        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 10.8333597, longitude: 106.670341)))
//        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 10.8333597, longitude: 106.670341)))
//        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 123, longitude: 123)))
//        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 1010, longitude: 12.3360004)))
//        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 12.25, longitude: 2.29999995)))
//        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 1032, longitude: 22)))
//        markers.append(GMSMarker(position: CLLocationCoordinate2D(latitude: 1, longitude: 10)))
        return markers
    }
}

struct Position {
    var latitude: Double
    var longitude: Double
    
    init(lat: Double, long: Double) {
        self.latitude = lat
        self.longitude = long
    }
}
