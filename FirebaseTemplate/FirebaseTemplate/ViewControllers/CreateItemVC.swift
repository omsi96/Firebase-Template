//
//  CreateItemVC.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 7/11/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit

// Move this to models later
// Change this model into any thing else
struct SOMETHING: Codable{
    var field1: String
    var field2: String
    var field3: String
}

struct Ma3had: Codable{
    var name: String
    var instagramAccount: String
    var government: String
}


class CreateItemVC: UIViewController {

    @IBOutlet var field1: UITextField!
    @IBOutlet var field2: UITextField!
    @IBOutlet var field3: UITextField!
    @IBOutlet var collectionField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createItem(){
        let f1 = field1.text!
        let f2 = field2.text!
        let f3 = field3.text!
        let collection = collectionField.text!
        let ma3had = Ma3had(name: f1, instagramAccount: f2, government: f3)
        
        Networking.createItem(ma3had, inCollection: "m3ahed", success: {
            self.alert(title: "Whowooooo", message: "Ma3had \(ma3had) has been created!!!")
        }) { error in
            self.alert(title: "OPPPPPS", message: "Couldn't create this ma3had")
        }
        
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
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
