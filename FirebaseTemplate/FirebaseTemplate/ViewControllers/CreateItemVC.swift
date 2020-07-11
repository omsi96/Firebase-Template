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
        let object = SOMETHING(field1: f1, field2: f2, field3: f3)
        
        Networking.createItem(object, inCollection: collection, success: {
            // ✅ Success
            self.alert(title: "Success ✅", message: "item \(object) has been addedd successfully to firebase at: \(collection)")
        }, fail: { error in
            // ❌ Fail
            self.alert(title: "Fail ❌", message: "")
        })
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
