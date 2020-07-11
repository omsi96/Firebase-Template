
import Foundation
import Firebase
import CodableFirebase
import FirebaseFirestore

// Auth networking
extension Networking//: NetworkableAuth
{
    
    static func getUserFromUid(userType: String, uid: String, completion: @escaping (User)->())
    {
        Firestore.firestore().collection(userType).document(uid).getDocument { (snapshot, error) in
            guard let snapshot = snapshot,
                let _ = snapshot.data() else {return}
            
            let decodedRegistrant = try! FirebaseDecoder().decode(User.self, from: snapshot.data()!)
            
            completion(decodedRegistrant)
        }
    }
    
    
    static func signIn(user: SignInCredentials, success: ((String) -> Void)? = nil, fail: ((Error?)->Void)? = nil)
    {
        
        Auth.auth().signIn(withEmail: user.email, password: user.password) { (result, error) in
                
            guard error == nil else  {
                DispatchQueue.main.async {fail?(error)}
                return
            }
            guard let result = result else {
                DispatchQueue.main.async {fail?(error)}
                return
            }
            let uid = result.user.uid
            let documentPath = "users/" + uid
            Firestore.firestore().document(documentPath).getDocument { (snapshot, error) in
                guard let snapshot = snapshot, error == nil else{
                    fail?(error)
                    return
                }
                guard let _ = snapshot.data() else {
                    let error = NSError(domain: "You are signing in for different user type, try using another type.", code: 335, userInfo: ["1": ""])
                    DispatchQueue.main.async {fail?(error)}
                    return
                }
                DispatchQueue.main.async {success?(result.user.uid)}
            }
        }
    }
    
    
    static func signOut(success: (()->Void)? = nil, fail: (()->Void)? = nil)
    {
        UserDefaults.standard.setValue(nil, forKey: "userType")
        UserDefaults.standard.setValue(nil, forKey: "signedIn")
        UserDefaults.standard.setValue(nil, forKey: "uid")
        
        guard let _ = Auth.auth().currentUser?.uid else{
            success?()
            print("User is already signed out")
            return
        }
        do{
            try Auth.auth().signOut()
            success?()
            print("User has been signed out, current user = ")
            print(Auth.auth().currentUser.debugDescription)
        }
        catch{
            fail?()
        }
    }
    
    
    static func forgetPassword(email: String,success: (()->Void)? = nil, fail: (()->Void)? = nil)
    {
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            
            if error == nil
            {
                success?()
            }
            else {
                fail?()
            }
        }
    }
    
}
