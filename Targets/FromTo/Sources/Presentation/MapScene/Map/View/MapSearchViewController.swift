//
//  MapViewController.swift
//  FromTo
//
//  Created by 송영모 on 2023/08/04.
//  Copyright © 2023 alom.com. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

import SnapKit

final class MapSearchViewController: BaseViewController {
    let viewModel: MapSearchViewModel
    
    // MARK: - Properties
    
    private var locationManager: CLLocationManager = .init()
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = .init()
    private let mapView: MKMapView = .init()
    
    // MARK: - Initializer
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: MapSearchViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch locationManager.authorizationStatus {
        case .denied, .restricted, .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        default:
            if let location = locationManager.location {
                let defaultLocation = location.coordinate
                let defaultSpanValue = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                mapView.setRegion(MKCoordinateRegion(center: defaultLocation, span: defaultSpanValue), animated: true)
            }
            break
        }
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        mapView.mapType = MKMapType.standard
        mapView.userTrackingMode  = .follow
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
        mapView.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([mapView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}

extension MapSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        debugPrint(userLocation.coordinate)
//        let defaultLocation = userLocation.coordinate
//        let defaultSpanValue = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        mapView.setRegion(MKCoordinateRegion(center: defaultLocation, span: defaultSpanValue), animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(annotation)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view)
    }
}

extension MapSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        locationManager = manager
    }
}
