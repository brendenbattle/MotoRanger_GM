//
//  MapVC.swift
//  MotoRangerGM
//
//  Created by Joy Umali on 12/14/16.
//  Copyright © 2016 Joy Umali. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup mapView
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.mapType = kGMSTypeHybrid
        mapView.isMyLocationEnabled = true
        view = mapView
        
    // Create a marker in the center of the map
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
    marker.title = "Sidney"
    marker.snippet = "Australia"
    marker.map = mapView
    
    
    }

}




