

import Foundation
import Foundation
import UIKit
import Firebase
import CodableFirebase
import FirebaseFirestore



class Networking// : Networkable
{
    let ref: DocumentReference? = nil
    let db = Firestore.firestore()
    
    
    static func getUserId() -> String?{
        Auth.auth().currentUser?.uid
    }
    
    /// **success only**
    static func createItem<T:Codable>(_ item: T, inCollection COLLECTION_NAME: String, withDocumentId documentId: String = "",  success: @escaping ()-> Void)
    {
        createItem(item, inCollection: COLLECTION_NAME, withDocumentId: documentId, success: success, fail: {_ in})
    }

    
    static func createItem<T:Codable>(_ item: T, inCollection COLLECTION_NAME: String, withDocumentId documentId: String = "",  success: @escaping ()-> Void, fail: @escaping (Error?)->())
    {
        
        print("⚙️ Creating item \(item.dictionary.debugDescription) of type: \(item.self) at collection: \"\(COLLECTION_NAME)\" ...")
        
        let encoded = try! FirestoreEncoder().encode(item)
        
        var ref = Firestore.firestore()
            .collection(COLLECTION_NAME)
            .document()
        ref = documentId != "" ? Firestore.firestore().collection(COLLECTION_NAME).document(documentId) : ref
        
        ref.setData(encoded) { (error) in
                if error == nil{
                    // ✅
                    
                    DispatchQueue.main.async {
                        print("✅ item of type: \(item.self) at collection: \(COLLECTION_NAME) has been created successfully ")
                        success()
                    }
                }
                else{
                    // ❌
                    DispatchQueue.main.async {
                        print("❌ item of type: \(item.self) at collection: \(COLLECTION_NAME) has  encountered an error: \n❌❌❌❌\n", error.debugDescription)
                        fail(error)
                    }
                    
                }
        }
    }
    
    static func getListOf<T: Codable>(COLLECTION_NAME: String, success: @escaping([T])-> Void)
    {
        getListOf(COLLECTION_NAME: COLLECTION_NAME, success: success) { err in}
    }
    
    static func getListOf<T: Codable>(COLLECTION_NAME: String, success: @escaping([T])-> Void, fail: @escaping(Error?)-> Void)
    {
        Firestore.firestore().collection(COLLECTION_NAME).getDocuments { (snapshot, error) in
            if error == nil{
                // there is no error
                if let snapshot = snapshot{
                    // There is data
                    do{
                        let items = try FirebaseDecoder().decode([T].self, from: snapshot.documents.map{$0.data() as Any})
                        DispatchQueue.main.async {
                            success(items)
                        }
                    }
                    catch{
                        DispatchQueue.main.async {
                            print("🔥 Couldn't cast type \(T.self)\n", error)
                            fail(error)
                        }
                    }
                }
            }
            else{
                fail(error)
            }
        }
    }
    
    
    static func getSingleDocument<T: Codable>(_ DOCUMENT_PATH: String, success: @escaping(T)-> Void)
    {
        getSingleDocument(DOCUMENT_PATH, success: success) { error in}
    }

    
    static func getSingleDocument<T: Codable>(_ DOCUMENT_PATH: String, success: @escaping(T)-> Void, fail: @escaping(Error?)->Void)
    {
        Firestore.firestore().document(DOCUMENT_PATH).getDocument { (snapshot, error) in
            if error == nil{
                // there is no error
                if snapshot != nil {
                    // There is data
                    guard let data =  snapshot?.data() else{
                        fail(error)
                        print("🔥 no data was found for", DOCUMENT_PATH)
                        return
                    }
                    do{
                        let item = try FirebaseDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            success(item)
                        }
                    }
                    catch{
                        DispatchQueue.main.async {
                            fail(error)
                            print("🔥 Couldn't cast type \(T.self)\n", error)
                        }
                    }
                }
            }
        }
    }
    
    
}
