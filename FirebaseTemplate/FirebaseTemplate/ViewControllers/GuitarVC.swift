//
//  GuitarVC.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 7/11/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit

class GuitarVC: UIViewController {


    @IBOutlet var guiarTypeField: UITextField!
    @IBOutlet var guiarColorField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createGuitar(){
        let type = guiarTypeField.text!
        let color = guiarColorField.text!
        let guitar = Guitar(type: type, color: color)
        Networking.createItem(guitar, inCollection: "guitars", success: {
            print("Guitar is created!")
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
