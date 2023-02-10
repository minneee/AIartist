//
//  ImageViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/12.
//

import UIKit
import MobileCoreServices
import FirebaseStorage

class ImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    
    @IBOutlet weak var imagebutton: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imgView2: UIImageView!
    
    
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var flagImageSave = false
    
    
    let storage = Storage.storage().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image2 = imgView2.image
        uploadimage(img: image2!)
        
        /*
        //url로 이미지 바꾸기
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/epoch-7c08e.appspot.com/o/hoho%2FP20191113_144033684_BAA80E36-2EB8-46EB-9675-4DF1E1782F76.JPG?alt=media&token=d1d79697-e6fb-435c-a41f-96fd22c54c82")
        let data = try! Data(contentsOf: url!)
        imgView2.image = UIImage(data: data)
       */
    }
    
    @IBAction func imageButtonAction(_ sender: Any) {
        //사진 들어가서 사진 가져오기
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
            
        }
        
        else{
            print("실패")
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            /*
             사진저장
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
             */
            
            
            imgView.image = captureImage
            
            self.dismiss(animated: true, completion: nil)
            
            let image = captureImage
            uploadimage(img: image!)
            
            let image2 = imgView2.image
            uploadimage(img: image2!)
            
            //downloadimage(imgview: imgView2)
            
            
            //let data = captureImage
            
            //let imgRef = storage.child("minmin/test3.png")
        
            
            //if let uploadData = data!.pngData(){
            //    imgRef.putData(uploadData, metadata: nil)
            //}
           
            /*
            func uploadimage(img:UIImage){
            
                var data = Data()
                data = img.jpegData(compressionQuality: 0.8)!
                let filePath = "minmin/img9"
                let metaData = StorageMetadata()
                metaData.contentType = "image/png"
                storage.storage.reference().child(filePath).putData(data,metadata: metaData){
                    (metaData,error) in if let error = error{
                        print(error.localizedDescription)
                        return
                    }else{
                        print("성공")
                    }
                }
            }

            
            func downloadimage(imgview:UIImageView){
                storage.storage.reference(forURL: "gs://epoch-7c08e.appspot.com/hoho/testimage002").downloadURL { (url,error) in
                    let data = NSData(contentsOf:url!)
                let image = UIImage(data: data! as Data)
                imgview.image = image
                
                }
            }
            */
            }
        
        
    }
    
    func uploadimage(img:UIImage){
    
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let filePath = "minmin/img9"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.storage.reference().child(filePath).putData(data,metadata: metaData){
            (metaData,error) in if let error = error{
                print(error.localizedDescription)
                return
            }else{
                print("성공")
            }
        }
    }

    
    func downloadimage(imgview:UIImageView){
        storage.storage.reference(forURL: "gs://epoch-7c08e.appspot.com/hoho/testimage002").downloadURL { (url,error) in
            let data = NSData(contentsOf:url!)
        let image = UIImage(data: data! as Data)
        imgview.image = image
        
        }
    }
}
