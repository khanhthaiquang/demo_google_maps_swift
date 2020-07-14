//
//  GoogleMapsManager.swift
//  DemoMaps
//
//  Created by Khánh's Mac on 3/3/20.
//  Copyright © 2020 Khánh's Mac. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

enum TypeMaps {
    case Normal
    case Hybrid
    case Satellite
    case Terrain
    case None
}

class GoogleMapsManager: NSObject {
    
    let API_KEY = "AIzaSyAveEqSPMbbEVgL_OYHXduyNpvSV3DBLJY"
    private var mapView : GMSMapView!
    private var locationManager : CLLocationManager!
    private var placeClient : GMSPlacesClient!
    var likelyPlace: [GMSPlace] = []
    var selectedPlace : GMSPlace?
    let zoomLevel: Float = 14.0
    
    static let share : GoogleMapsManager = {
        let instance = GoogleMapsManager()
        return instance
    }()
    func configAPIKey() {
        GMSPlacesClient.provideAPIKey(API_KEY)
        GMSServices.provideAPIKey(API_KEY)
    }
    
    func initWithFrame(frame: CGRect) -> GMSMapView {
        if mapView == nil {
            mapView = GMSMapView()
            let camera = GMSCameraPosition.camera(withLatitude: 10.8033079, longitude: 106.6234154, zoom: 14.5)
            mapView = GMSMapView.map(withFrame: frame, camera: camera)
            mapView.settings.myLocationButton = true
            mapView.isMyLocationEnabled = true
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.delegate = self
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 50
            if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
                locationManager.requestWhenInUseAuthorization()
            } else {
                locationManager.startUpdatingLocation()
            }
            placeClient = GMSPlacesClient.shared()
        }
        return mapView
    }

    func customMarkerWith(lat: CLLocationDegrees, long: CLLocationDegrees, title: String, snippet: String, imageMarker: UIImage) -> GMSMarker {
        let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let marker = GMSMarker(position: position)
        marker.title = title
        marker.snippet = snippet
        marker.tracksInfoWindowChanges = true
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.icon = imageMarker
        marker.map = mapView
        return marker
    }

    func createMarker(lat: CLLocationDegrees?, long: CLLocationDegrees?, title: String?, snippet: String?) -> GMSMarker {
        let position = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: long ?? 0)
        let marker = GMSMarker(position: position)
        marker.title = title ?? ""
        marker.snippet = snippet ?? ""
        marker.tracksInfoWindowChanges = true
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.map = mapView
        return marker
    }
    
    func moveToListLocations(markers: [GMSMarker]?) {
        for marker in markers! {
            createMarker(lat: marker.position.latitude, long: marker.position.longitude, title: marker.title, snippet: marker.snippet)
        }
        if markers!.count > 0 {
            let firstLocation = markers?.first!.position
            var bounds = GMSCoordinateBounds(coordinate: firstLocation!, coordinate: firstLocation!)
            for marker in markers! {
                bounds = bounds.includingCoordinate(marker.position)
            }
            let update = GMSCameraUpdate.fit(bounds, withPadding: 19)
            mapView.animate(with: update)
        }
    }

    func changeTypeMaps(type: TypeMaps) {
        switch type {
            case .None:
                mapView.mapType = .none
            case .Hybrid:
                mapView.mapType = .hybrid
            case .Satellite:
                mapView.mapType = .satellite
            case .Terrain:
                mapView.mapType = .terrain
            case .Normal:
                mapView.mapType = .normal
            default:
                break
        }
    }
}

extension GoogleMapsManager: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        print("tap \(name): \(placeID)")
        let infoMarker = GMSMarker()
        
        //attack an info window to the POI using marker
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0
        infoMarker.infoWindowAnchor.y = 0.2
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }

}


extension GoogleMapsManager : CLLocationManagerDelegate {
    //handle incoming location events
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        let camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .restricted:
                  print("Location access was restricted.")
            case .denied:
                mapView.isHidden = false
                print("Location access was restricted.")
            case .notDetermined:
                print("Location status not determined.")
            case .authorizedAlways:
                fallthrough
            case .authorizedWhenInUse:
                print("Location status is OK.")
            default:break
        }
    }
    
    //handle when location manager error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("location manager error: \(error)")
    }
    
    
}
