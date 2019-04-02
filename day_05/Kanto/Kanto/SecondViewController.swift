//
//  SecondViewController.swift
//  Kanto
//
//  Created by Wahiba BELLAHCENE on 4/1/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segButton: UISegmentedControl!
    
    var currentLoc: findLoc?
    var locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 48.896701, longitude: 2.318544)
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        centerMapOnLocation(location: initialLocation)
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted ||
                CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                    self.locationManager.requestAlwaysAuthorization()
                    self.locationManager.requestWhenInUseAuthorization()
            }
            locationManager.delegate = self
            locationManager.desiredAccuracy = 1.0
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
        DispatchQueue.main.async {
            self.mapView.addAnnotations(Data.places)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        self.mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error :", error)
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue)
    {
        if segue.identifier == "goToMap" {
            if let currentLoc = self.currentLoc {
                let listloc = MKCoordinateRegion(center: currentLoc.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                self.mapView.setRegion(listloc, animated: true )
            }
        }
    }
    
    @IBAction func segButtonAction(_ sender: Any) {
        switch (segButton.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    @IBAction func myLoc(_ sender: Any) {
        if let myLoc = self.locationManager.location?.coordinate {
            let setLoc = MKCoordinateRegionMakeWithDistance(myLoc, regionRadius, regionRadius)
            self.mapView.setRegion(setLoc, animated: true)
        }
    }
}

extension SecondViewController {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? findLoc else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}

