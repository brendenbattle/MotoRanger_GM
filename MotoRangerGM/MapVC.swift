//
//  MapVC.swift
//  MotoRangerGM
//
//  Created by Joy Umali on 12/14/16.
//  Copyright © 2016 Joy Umali. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    // Default mapView location when permission is not granted
    let defaultLocation = CLLocation(latitude: 36.3714, longitude: -121.9017)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the location manager
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        // Setup mapView
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.mapType = kGMSTypeHybrid
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view = mapView
        
        // This code did not work because cannot add self as subview.
        // Add the map to the view, hide it until we've got a location to update
//        view.addSubview(mapView)
//        mapView.isHidden = true
        
        // Add markers for places nearby. Later change to markers that user logs.
        func updateMarkers() {
            mapView.clear()
        
            //Get nearby places and add markers to the map
            placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
                if let error = error {
                    print("Current Place error: \(error.localizedDescription)")
                    return
                }
        
                if let likelihoodList = placeLikelihoods {
                    for likelihood in likelihoodList.likelihoods {
                let place = likelihood.place
                
                let marker = GMSMarker(position: place.coordinate)
                marker.title = place.name
                marker.snippet = place.formattedAddress
                marker.map = self.mapView
                }
            }
        })
    }
}
        
//        // Create a marker in the center of the map
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sidney"
//        marker.snippet = "Australia"
//        marker.map = mapView
    

    


}


