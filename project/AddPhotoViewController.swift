//
//  AddPhotoViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/29.
//

import UIKit
import MobileCoreServices
import Alamofire


class AddPhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var styleUrl : URL? = nil
    
    
    @IBOutlet weak var styleImage: UIImageView!
    
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var drawButton: UIButton!
    
    @IBOutlet weak var styleButton: UIButton!
    
    @IBOutlet weak var contentButton: UIButton!
    
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    //var flagImageSave = false
   
    
    //let storage = Storage.storage().reference()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(styleUrl)
        
        if styleUrl != nil{
            
            
            styleButton.layer.isHidden = true
            
            let data = try! Data(contentsOf: styleUrl!)
            styleImage.image = UIImage(data: data)
            
        }
    }
    
    func contAIPost(){
        let apiURL = "http://13.209.4.65:3030/input/content/ai"
            
        let uName = UserDefaults.standard.string(forKey: "id")!
        let param: Parameters = ["userID": uName]
        AF.request(apiURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON() { [self] response in
                switch response.result {
                case .success(let response):
               
                    if let jsonObj = response as? NSDictionary
                    {
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("ai const 성공")
                            
                            let jsonUrl = jsonObj.object(forKey: "content") as! String
                            let url = URL(string: jsonUrl)
                            let data = try! Data(contentsOf: url!)
                            contentImage.image = UIImage(data: data)
                            
                            
                        }else{
                            print("ai const 실패")
                        }
                    }
                case .failure(let error):
                    print("서버통신 실패")
                        
                    let failAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                        
                    let failAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    failAlert.addAction(failAction)
                    self.present(failAlert, animated: true, completion: nil)
                    }
                }
        }
    
    
    func contPost(){
        let apiURL = "http://13.209.4.65:3030/input/content/nst"
            
        let uName = UserDefaults.standard.string(forKey: "id")!
        let param: Parameters = ["userID": uName]
        AF.request(apiURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON() { [self] response in
                switch response.result {
                case .success(let response):
               
                    if let jsonObj = response as? NSDictionary
                    {
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("const 성공")
                           
                            let jsonUrl = jsonObj.object(forKey: "content") as! String
                            let url = URL(string: jsonUrl)
                            let data = try! Data(contentsOf: url!)
                            contentImage.image = UIImage(data: data)
                            
                            
                        }else{
                            print("const 실패")
                        }
                    }
                case .failure(let error):
                    print("서버통신 실패")
                        
                    let failAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                        
                    let failAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    failAlert.addAction(failAction)
                    self.present(failAlert, animated: true, completion: nil)
                    }
                }
        }
    
    
    
    
    func stylePost(){
        let apiURL = "http://13.209.4.65:3030/input/style/nst"
            
        let uName = UserDefaults.standard.string(forKey: "id")!
        let param: Parameters = ["userID": uName]
        AF.request(apiURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON() { [self] response in
                switch response.result {
                case .success(let response):
               
                    if let jsonObj = response as? NSDictionary
                    {
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("style 성공")
                           
                            let jsonUrl = jsonObj.object(forKey: "content") as! String
                            let url = URL(string: jsonUrl)
                            let data = try! Data(contentsOf: url!)
                            styleImage.image = UIImage(data: data)
                            
                        }else{
                            print("style 실패")
                        }
                    }
                case .failure(let error):
                    print("서버통신 실패")
                        
                    let failAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                        
                    let failAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    failAlert.addAction(failAction)
                    self.present(failAlert, animated: true, completion: nil)
                    }
                }
        }
    
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    @IBAction func styleButtonAction(_ sender: Any) {
        
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
   
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
           
            present(imagePicker, animated: true, completion: nil)
        }
        
        else{
            print("실패")
        }
        
        
        //api
        if styleUrl == nil{
            
            stylePost()
            
        }
        styleButton.layer.isHidden = true
        
    }
    
    
    
    
    
    @IBAction func contentButtonAction(_ sender: Any) {
        
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
           
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            
            present(imagePicker, animated: true, completion: nil)
         
        }
        
        else{
            print("실패")
        }
      
        
        //api
        if styleUrl == nil{
            contPost()
        } else{
            contAIPost()
        }
      
        contentButton.layer.isHidden = true
  
    }
    
    
    @IBAction func drawButtonAction(_ sender: Any) {
        if styleUrl == nil{
            go(where: "LoadingTwoViewController")
        } else{
            go(where: "LoadingViewController")
        }
        
    }
    
   
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            //styleImage.image = captureImage
            
            self.dismiss(animated: true, completion: nil)

            
        }
    }
     
    
    func go(where: String) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: `where`)
        self.navigationController?.pushViewController(pushVC!, animated: true)
        print("go!")
    }
    
}
