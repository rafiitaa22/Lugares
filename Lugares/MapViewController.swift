//
//  MapViewController.swift
//  Lugares
//
//  Created by Rafael Larrosa Espejo on 7/10/16.
//  Copyright © 2016 Rafael Larrosa Espejo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var place: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.showsTraffic = true
        self.mapView.showsScale = true
        self.mapView.showsCompass = true
        
        print("El mapa debe mostrar \(place.name)")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(place.location) { [unowned self] (placemarks, error) in
            if error == nil{
                //ha encontrado la posición
                for placemark in placemarks!{
                    print(placemark)
                    
                    let anotation = MKPointAnnotation()
                    anotation.title = self.place.name
                    anotation.subtitle = self.place.type
                    anotation.coordinate = (placemark.location?.coordinate)!
                    self.mapView.showAnnotations([anotation], animated: true)
                    self.mapView.selectAnnotation(anotation, animated: true)
                    
                    
                    
                }
            }else{
                print("Ha habido un error al ubicar el lugar")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
//mostrar una imagen en el pincho
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        if annotation.isKind(of: MKUserLocation.self){ //ubicación del usuario no hacemos nada especial
            return nil
        }
        
        var annotationView : MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        imageView.image = UIImage(data:self.place.image! as Data)
        annotationView?.leftCalloutAccessoryView = imageView
        annotationView?.pinTintColor = UIColor.green
        return annotationView
        
    }
}
