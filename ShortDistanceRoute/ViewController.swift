//
//  ViewController.swift
//  ShortDistanceRoute
//
//  Created by Saadet Şimşek on 03/08/2024.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    var annotationsArray = [MKPointAnnotation]()
    
    let mapView: MKMapView = {
       let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let addAdressButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addAddress"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let routeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "route"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reset"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        mapView.addSubview(addAdressButton)
        mapView.addSubview(routeButton)
        mapView.addSubview(resetButton)
        addConstraints()
        addTarget()
    }
    
    private func addTarget(){
        addAdressButton.addTarget(self,
                                  action: #selector(didTapAddAddressButton),
                                  for: .touchUpInside)
        routeButton.addTarget(self,
                              action: #selector(didTapRouteButton),
                              for: .touchUpInside)
        resetButton.addTarget(self,
                              action: #selector(didTapResetButton),
                              for: .touchUpInside)
    }
    
    @objc private func didTapAddAddressButton(){
        alertAddAddress(title: "Add Address",
                        placeholder: "Enter the address") { text in
            self.setupPlacemark(addressPlace: text)
        }
     
      //  AlertError(title: "Error", message: "Server not used")
    }
    
    @objc private func didTapRouteButton(){
        print("route")
    }
    
    @objc private func didTapResetButton(){
        print("reset")
    }
    
    private func setupPlacemark(addressPlace: String){
        let geocoder = CLGeocoder() //core location adresi coğrafi kordinatlara dönüştürme
        geocoder.geocodeAddressString(addressPlace) {[self] placemarks, error in
            if let error = error {
                print(error)
                AlertError(title: "Error", message: "The server is unavailable. Try adding the address again")
                return
            }
            
            guard let placemarks = placemarks else{
                return
            }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation() // mapkit haritaya yer işaretleri ekleme
            annotation.title = "\(addressPlace)"
            
            guard let placemarkLocation = placemark?.location else {
                return
            }
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationsArray.append(annotation)
            
            if annotationsArray.count > 2 {
                routeButton.isHidden = false
                resetButton.isHidden = false
            }
            
            mapView.showAnnotations(annotationsArray, animated: true)
        }
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAdressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAdressButton.heightAnchor.constraint(equalToConstant: 70),
            addAdressButton.widthAnchor.constraint(equalToConstant: 70),
            
            routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            routeButton.heightAnchor.constraint(equalToConstant: 100),
            routeButton.widthAnchor.constraint(equalToConstant: 100),
            
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            resetButton.heightAnchor.constraint(equalToConstant: 100),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}

