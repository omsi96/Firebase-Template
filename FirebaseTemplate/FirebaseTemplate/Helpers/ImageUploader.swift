

import Foundation
import UIKit

protocol ImageSetter: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var delegate: UIViewController {get}
    var imagePicker: UIImagePickerController {get}
}

extension ImageSetter
{
    /// Push the picker view to the ViewController
    func viewPickerView()
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            delegate.present(imagePicker, animated: true, completion: nil)
        }
    }
}
    
//    func sendPickedImageToServer(selectedImage: UIImage?)
//    {
//        let url = API.updateProfile(UpdateProfile(gender: nil, phone: nil, boxID: nil)).request.url!
//
//        guard let selectedImage = selectedImage else {
//            delegate.dismiss(animated: true, completion: nil)
//            return
//        }
//        AlamofireRequests.uploadImage(url: url, image: selectedImage, parameterName: "image", success: { imagePath in
//            self.delegate.dismiss(animated: true, completion: nil)
//        }, fail: {
//            print("Couln't upload image! sorry!")
//        })
//    }
//  }
