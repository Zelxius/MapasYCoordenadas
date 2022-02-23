//
//  ReverseGeocoding.swift
//  MapasYcoordenadas
//
//  Created by Colimasoft on 22/02/22.
//

import UIKit
import MapKit
import CoreLocation
class ReverseGeocoding: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var direccion: UILabel!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let localizacion = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: localizacion, span: span)
        self.mapa.setRegion(region, animated: true)
        self.mapa.showsUserLocation = true
        
        let geocoding = CLGeocoder()
        geocoding.reverseGeocodeLocation(location) { (places:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let place = places?.first {
                    self.direccion.text = "\(place.thoroughfare ?? "sin info") \(place.postalCode ?? "sin info") \(place.country ?? "sin info")"
                }
            }else{
                print("Error en reverse")
            }
    }
}
    



}
