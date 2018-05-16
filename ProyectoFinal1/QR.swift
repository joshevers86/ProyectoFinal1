//
//  QR.swift
//  ProyectoFinal1
//
//  Created by Jose Navarro Alabarta on 24/2/18.
//  Copyright © 2018 Jose Navarro Alabarta. All rights reserved.
//

import UIKit
import AVFoundation

class QR: UIViewController , AVCaptureMetadataOutputObjectsDelegate{

    var sesion : AVCaptureSession? = nil
    var capa: AVCaptureVideoPreviewLayer? = nil
    var marcoQR : UIView? = nil
    var urls : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Decode QR"
        
        let dispositivo = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            
            let entrada = try AVCaptureDeviceInput(device: dispositivo!)
            sesion = AVCaptureSession()
            sesion?.sessionPreset = AVCaptureSession.Preset.photo
            sesion?.addInput(entrada)
            
            let metaDatos = AVCaptureMetadataOutput()
            sesion?.addOutput(metaDatos)
            metaDatos.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDatos.metadataObjectTypes = [.qr]
            capa = AVCaptureVideoPreviewLayer(session: sesion!)
            //Esto es para que respete el acpeto de la camara
            capa?.frame = view.layer.bounds
            capa?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            capa?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            //se establece el tamaño de toda la vista que lo contiene
            //capa?.frame = view.layer.bounds
            //agregar la capa de la vista
            view.layer.addSublayer(capa!)
            marcoQR = UIView()
            marcoQR?.layer.borderWidth = 3
            marcoQR?.layer.borderColor = UIColor.red.cgColor
            view.addSubview(marcoQR!)
            
            sesion?.startRunning()
        }catch {
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !(sesion?.isRunning)! {
            sesion?.startRunning()
            marcoQR?.frame = CGRect.zero
        }
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        marcoQR?.frame = CGRect.zero
        if (metadataObjects.isEmpty || metadataObjects.count == 0) {
            return
        }
        
        let objMetadato = metadataObjects.first as? AVMetadataMachineReadableCodeObject
        if objMetadato?.type == .qr {
            let objetoBordes =  capa?.transformedMetadataObject(for: objMetadato! )
            marcoQR?.frame = (objetoBordes?.bounds)!
            if(objMetadato?.stringValue != nil) {
                self.urls = objMetadato?.stringValue
                               
                //AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                //esto pasa a la siguiente vista automaticamente?
                let navegacionControler = self.navigationController?.viewControllers.first
                navegacionControler?.performSegue(withIdentifier: "detalles", sender: self)
            }
        }
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

