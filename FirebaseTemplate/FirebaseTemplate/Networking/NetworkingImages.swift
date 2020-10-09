
import Foundation

import FirebaseStorage
import FirebaseFirestore
import UIKit
extension Networking
{
    static func uploadImage(path: String, imageName: String, image: UIImage, success: @escaping ()->())
    {
        let imageName = imageName + ".png"
        guard let imageData = image.pngData() else {return}
        let ref = Storage.storage().reference()
        let imageRef = ref.child(path).child(imageName)
        imageRef.putData(imageData, metadata: .none) { (storageMetaData, error) in
            guard error == nil else {
                print("🔥 ERROR WHILE UPLOADING IMAGE")
                return
            }
            DispatchQueue.main.async{
                print("✅ Image has been uploaded successfully!")
                success()
            }
        }
    }
    
    
    static func downlodImage(storagePath: String, success: @escaping(URL)->()){
        Storage.storage().reference().child(storagePath).downloadURL { (url, error) in
            if error == nil{
                if let url = url{
                    DispatchQueue.main.async {
                        success(url)
                    }
                }
                else{
                    print("Error occurred while getting thtr ulss for th eimages with url: ", url)
                }
            }
            else{
                print("There is an error while downloading the imges", error!)
            }
        }
    }
}
