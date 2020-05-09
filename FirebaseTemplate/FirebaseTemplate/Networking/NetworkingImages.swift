
import Foundation

import FirebaseStorage
import FirebaseFirestore
import UIKit 
extension Networking
{
    static func uploadContractImage(path: String, imageName: String, image: UIImage, success: @escaping ()->())
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
                success()
            }
        }
    }
}
