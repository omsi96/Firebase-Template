
import Foundation
import Firebase
import CodableFirebase
import FirebaseFirestore

// Auth networking
extension Networking//: NetworkableAuth
{
    
    static func getUserFromUid<USER: User>(uid: String, completion: @escaping (USER)->())
    {
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            guard let snapshot = snapshot,
                  let _ = snapshot.data() else {return}
            
            let decodedRegisterant = try! FirebaseDecoder().decode(USER.self, from: snapshot.data()!)
            
            completion(decodedRegisterant)
        }
    }
    

    static func signIn(user: SignInCredentials, collectionName userType: String = "users", success: ((String) -> Void)? = nil, fail: (()->())? = nil)
    {
        print("💂🏻‍♀️ Signing in the user: \(user)")
        Auth.auth().signIn(withEmail: user.email, password: user.password) { (result, error) in
            if let error = error{
                print("☹️💂🏻‍♀️ user couldn't sign in with error: \(error)")
                DispatchQueue.main.async {
                    fail?()
                }
                return
            }
            guard let result = result else {return}
            UserDefaults.standard.set(true, forKey: "signedIn")
            UserDefaults.standard.set(result.user.uid, forKey: "uid")
            UserDefaults.standard.set(userType, forKey: "userType")
            DispatchQueue.main.async {
                print("😍💂🏻‍♀️ user is authenticated \(result)")
                success?(result.user.uid)
            }
            
        }
    }
    
    static func signOut(success: (()->Void)? = nil, fail: (()->Void)? = nil)
    {
        UserDefaults.standard.setValue(nil, forKey: "userType")
        UserDefaults.standard.setValue(nil, forKey: "signedIn")
        UserDefaults.standard.setValue(nil, forKey: "uid")

        guard let _ = Auth.auth().currentUser?.uid else{
            DispatchQueue.main.async {
                success?()
            }
            print("User is already signed out")
            return
        }
        do{
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                success?()
            }
            print("User has been signed out, current user = ")
            print(Auth.auth().currentUser.debugDescription)
        }
        catch{
            DispatchQueue.main.async {
                fail?()
            }
        }
    }
    
    
    static func forgetPassword(email: String,success: (()->Void)? = nil, fail: (()->Void)? = nil)
    {
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            
            DispatchQueue.main.async {
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
    
}
