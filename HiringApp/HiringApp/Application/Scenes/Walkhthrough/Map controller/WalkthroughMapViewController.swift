//
//  WalkthroughMapViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit
import MapKit

class WalkthroughMapViewController: UIViewController {
    
    let mapView : MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        setMapRegion()
    }
    
    //MARK: - Private API
    private func layout() {
        view.addSubviewWithAutolayout(mapView)
        
        mapView.fillSuperview()
    }
    
    private func setup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissMapController))
    }
    
    func dismissMapController() {
        dismiss(animated: true)
    }
    
    private func setMapRegion() {
        
        // Center map region
        let location = CLLocationCoordinate2D(latitude: 41.380951, longitude: 2.1832373)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let coordianteRegion = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(coordianteRegion, animated: true)
        
        // Add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
}
