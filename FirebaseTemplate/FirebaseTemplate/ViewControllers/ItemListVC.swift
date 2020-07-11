//
//  ItemListVC.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 7/11/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit

class ItemListVC: UITableViewController {

    @IBOutlet weak var collectionNameField: UITextField!
    
    // array of items has to be empty at first place
    
    var items: [SOMETHING] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // every time we get into this page, it reloads
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // Call this function to reload items
    func loadItems(){
        let collection = collectionNameField.text!
        Networking.getListOf(COLLECTION_NAME: collection) { (items: [SOMETHING]) in
            self.items = items
            self.tableView.reloadData()
        }
    }
    
    @IBAction func reload(_ sender: Any) {
        loadItems()
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let item = items[indexPath.row]
        cell.textLabel!.text = "\(item.field1) - \(item.field2) - \(item.field3)"
        return cell
    }
    


}
