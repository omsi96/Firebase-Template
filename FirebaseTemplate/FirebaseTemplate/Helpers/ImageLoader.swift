

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class ImageLoader
{
    var imageURL: String?
    
    init(imageURL: String)
    {
        self.imageURL = imageURL
    }
    
    
    func getImage(_ success: @escaping (UIImage)->Void)
    {
        guard let imageURL = imageURL else {return}
        
        guard let url = URL(string: imageURL) else {
            print("This is invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            if error != nil {
                print("Error occured while loading the image")
                return
            }
            guard let data = data else{return}
            
            guard let image = UIImage(data: data) else {
                print("Couldn't convert data to image")
                return
            }
            
            DispatchQueue.main.async {
                success(image)
            }
        }.resume()
        
    }
    
    static func getProfileImage(uid: String, success: @escaping (UIImage?)->Void)
    {
        
        let storageRef = Storage.storage().reference().child("usersImages")
        storageRef.child("\(uid).jpg").getData(maxSize: 1024*1024) { (data, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                success(UIImage(data: data))
            }

        }
    }
}
