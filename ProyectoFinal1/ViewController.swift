//
//  ViewController.swift
//  ProyectoFinal1
//
//  Created by Jose Navarro Alabarta on 24/2/18.
//  Copyright © 2018 Jose Navarro Alabarta. All rights reserved.
//

/*
 RUTAS:
 
 1. Crear una nueva ruta basada en las posiciones actuales del usuario (al dar un paseo por la ciudad).
 
 2. De cada ruta se deberá guardar:
 
 a. Nombre
 
 b. Foto
 
 c. Descripción
 
 3. Una ruta estará formada por puntos favoritos y de cada punto se deberá guardar:
 
 a. Nombre
 
 b. Posición
 
 4. Cada punto guardado deberá verse como un PIN en el mapa, el cual mostrará el nombre del punto al hacer tap sobre él.
 
 5. En todo momento se deberá poder mostrar la ruta creada sobre el mapa.
 
 6. El mapa, en la parte inferior, deberá contener un botón de para leer códigos QR relacionados con el lugar que se está visitando (ver descripción de la parte de QR más adelante)
 
 7. El mapa, en la parte inferior, deberá contener un botón para tomar la foto del punto actual. Esta foto se podrá tomar de la cámara o del carrete.
 
 QR:
 
 1. Leer un código QR
 
 2. Ir a la página a la que apunta dicho código.
 
 3. Poder regresar a la aplicación, en el punto en el que se encontraba.
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
        super.viewWillDisappear(animated)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detalles" {
            //Cuando la camara decodifica el codigo QR envia la URL a la vista WEB
            let vOrigen = sender as! QR
            //destino de la transicion
            let vc = segue.destination as! VC
            vOrigen.sesion?.stopRunning()
            vc.urls = vOrigen.urls
        }
    }
}

