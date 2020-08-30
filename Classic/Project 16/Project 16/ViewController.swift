//
//  ViewController.swift
//  Project 16
//
//  Created by Vyacheslav Pronin on 27/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate, WKNavigationDelegate {
    @IBOutlet var mapView: MKMapView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Theme", style: .done, target: self, action: #selector(themeSelection))
        
        let lonodon = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", site:
            URL(fileURLWithPath: "https://en.wikipedia.org/wiki/London"))
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", site: URL(fileURLWithPath: "https://en.wikipedia.org/wiki/Oslo"))
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", site: URL(fileURLWithPath: "https://en.wikipedia.org/wiki/Paris"))
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", site: URL(fileURLWithPath: "https://en.wikipedia.org/wiki/Rome"))
        let wachington = Capital(title: "Wachington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", site: URL(fileURLWithPath: "https://en.wikipedia.org/wiki/Washington,_D.C."))
        
        mapView.addAnnotations([lonodon, oslo, paris, rome, wachington])

    }
    
    @objc func themeSelection() {
        let ac = UIAlertController(title: "Choose Theme", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Standart", style: .default) { [weak self] _ in
            self?.mapView.mapType = MKMapType.standard
        })
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default) { [weak self] _ in
            self?.mapView.mapType = MKMapType.hybridFlyover
        })
        ac.addAction(UIAlertAction(title: "Satellite", style: .default){ [weak self] _ in
            self?.mapView.mapType = MKMapType.satellite
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
            annotationView?.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
            
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        if let vc  = storyboard?.instantiateViewController(identifier: "Web") as? WebViewController {
            
            vc.url = capital.site
            navigationController?.pushViewController(vc, animated: true)
            
        }
//        let placeName = capital.title
//        let placeInfo = capital.info
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
 //       present(ac, animated: true)
    }

}

