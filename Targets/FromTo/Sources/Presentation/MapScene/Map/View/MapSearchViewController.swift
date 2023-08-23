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
        debugPrint(userLocation.location)
        /*
         let geoCoder = CLGeocoder()
         guard let location = userLocation.location else { return }
         
         geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
         
         // Place details
         var placeMark: CLPlacemark!
         placeMark = placemarks?[0]
         
         // Address dictionary
         print(placeMark.addressDictionary)
         
         // Location name
         if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
         print(locationName)
         }
         
         // Street address
         if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
         print(street)
         }
         
         // City
         if let city = placeMark.addressDictionary!["City"] as? NSString {
         print(city)
         }
         
         // Zip code
         if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
         print(zip)
         }
         
         // Country
         if let country = placeMark.addressDictionary!["Country"] as? NSString {
         print(country)
         }
         
         })
         */
    }
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(annotation)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view)
    }
}
