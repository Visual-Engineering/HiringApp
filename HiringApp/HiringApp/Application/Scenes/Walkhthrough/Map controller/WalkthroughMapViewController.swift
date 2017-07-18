//
//  WalkthroughMapViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit
import MapKit

protocol WalkthroughMapViewControllerDelegate: class {
    func didDismissMap()
}

class WalkthroughMapViewController: UIViewController {
    
    enum Constants {
        static let latitude = 41.380951
        static let longitude = 2.1832373
    }
    
    weak var delegate: WalkthroughMapViewControllerDelegate?
    
    let mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        setMapRegion()
    }
    
    // MARK: - Private API
    private func layout() {
        view.addSubviewWithAutolayout(mapView)
        
        mapView.fillSuperview()
    }
    
    private func setup() {
        //MARK: TO-DO Localize this string
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissMapController))
    }
    
    func dismissMapController() {
       dismiss(animated: true, completion: {
            self.delegate?.didDismissMap()
        })
    }
    
    private func setMapRegion() {
        
        // Center map region
        let location = CLLocationCoordinate2D(latitude: Constants.latitude, longitude: Constants.longitude)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let coordianteRegion = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(coordianteRegion, animated: true)
        
        // Add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
}
