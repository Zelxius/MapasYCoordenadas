//
//  Coordenadas.swift
//  MapasYcoordenadas
//
//  Created by Colimasoft on 22/02/22.
//

import UIKit
import MapKit
import CoreLocation
class Coordenadas: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var mostrarCoordenadas: UILabel!
    
    var manager = CLLocationManager()
    var latitud : CLLocationDegrees!
    var longitud : CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.latitud = location.coordinate.latitude
            self.longitud = location.coordinate.longitude
        }
    }
    
    
    @IBAction func obtener(_ sender: UIButton) {
        mostrarCoordenadas.text = "Lat: \(latitud!), Long: \(longitud!)"
        //mostrarCoordenadas.text = "Lat: " + latitud + "Long: " longitud"
        
        let localizacion = CLLocationCoordinate2DMake(latitud, longitud)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: localizacion, span: span)
        mapa.setRegion(region, animated: true)
        mapa.showsUserLocation = true
    }
}
