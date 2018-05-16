//
//  VC.swift
//  QR
//
//  Created by Jose Navarro Alabarta on 19/2/18.
//  Copyright © 2018 Jose Navarro Alabarta. All rights reserved.
//

import UIKit
import WebKit

class VC: UIViewController {

    
    @IBOutlet weak var visorWeb: UIWebView!
    var urls : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = self.urls
        
        // en Info.plist añadir Clave App Transport Security Settings para cargar sitios Web
        // App Transport Security Settings
        //      Allow Arbitrary Loads in Web Content    YES
        //      Allow Arbitrary Loads                   YES
        if let url = URL(string: self.urls!) {
            let request = URLRequest(url: url)
            visorWeb.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
