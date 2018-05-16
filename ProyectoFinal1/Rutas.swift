//
//  Rutas.swift
//  ProyectoFinal1
//
//  Created by Jose Navarro Alabarta on 24/2/18.
//  Copyright © 2018 Jose Navarro Alabarta. All rights reserved.
//

//https://code.tutsplus.com/tutorials/create-a-custom-alert-controller-in-ios-10-swift-3--cms-27589
//https://makeapppie.com/2016/04/18/how-to-make-dynamic-uibuttons-in-swift/
//https://makeapppie.com/2016/06/22/using-the-navigation-bar-title-and-back-button-in-swift-3-0/

import UIKit
import CoreLocation
import MapKit

class Rutas: UIViewController {

    @IBOutlet weak var mapa: MKMapView!
    let clManejador = CLLocationManager()
    let radioRegion:CLLocationDistance = 100.0
    var posAnterior:CLLocation = CLLocation()
    var posInicial:CLLocation? = nil
    var distanciaAcumulada = 0.0
    var distancia = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.clManejador.delegate = self
        self.clManejador.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.clManejador.requestWhenInUseAuthorization()
        mapa.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func anyadirPin(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


extension Rutas : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.clManejador.startUpdatingLocation()
            self.clManejador.startUpdatingHeading()
            mapa.showsCompass = true
            mapa.isZoomEnabled = true
            mapa.isScrollEnabled = true
            self.clManejador.distanceFilter = 50.0
        }else{
            self.clManejador.stopUpdatingLocation()
            self.clManejador.stopUpdatingHeading()
            mapa.showsUserLocation = false
            mapa.showsCompass = false
            mapa.isZoomEnabled = false
            mapa.isScrollEnabled = false
        }
    }
    
    //se obtnienen los valores de los 6 paramétros del protocolo
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //let localizacionActual = locations.last
        let localizacionActual = self.clManejador.location!
        
        centerMapOnLocation(location: localizacionActual)
        
        if posInicial == nil{
            posInicial = localizacionActual
        }
        
        distancia = localizacionActual.distance(from: posInicial!)
        
        let pin = MKPointAnnotation() //MKPointAnnotation --> ya ha implementado el protocolo MKAnnotation
        pin.title = "\(localizacionActual.coordinate.latitude), \(localizacionActual.coordinate.longitude)"
        pin.subtitle = "\(distancia)"
        pin.coordinate = localizacionActual.coordinate
        mapa.addAnnotation(pin)
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, radioRegion * 2.0, radioRegion * 2.0)
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alerta = UIAlertController(title: "Error", message: "error \(error.localizedDescription)", preferredStyle: .alert)
        // boton OK
        let accionOk = UIAlertAction(title: "Ok", style: .default, handler:
        { accion in
            //hacer algo ..
        })
        
        alerta.addAction(accionOk)
        self.present(alerta, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //norteGeo.text = "\(newHeading.trueHeading)"
        //norteMg.text = "\(newHeading.magneticHeading)"
    }
    
}

extension Rutas : MKMapViewDelegate{
    
}


