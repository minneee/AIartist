//
//  AiListViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/29.
//

import UIKit
import Alamofire



class AiListViewController: UIViewController {

    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var image4: UIImageView!
    
    @IBOutlet weak var image5: UIImageView!
    
    
    @IBOutlet weak var name1: UILabel!
    
    @IBOutlet weak var name2: UILabel!
    
    @IBOutlet weak var name3: UILabel!
    
    @IBOutlet weak var name4: UILabel!
    
    @IBOutlet weak var name5: UILabel!
    
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var goButton2: UIButton!
    
    @IBOutlet weak var goButton3: UIButton!
    
    @IBOutlet weak var goButton4: UIButton!
    
    @IBOutlet weak var goButtton5: UIButton!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    
    
    var urls: [URL] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.isHidden = true
        goButton2.layer.isHidden = true
        goButton3.layer.isHidden = true
        goButton4.layer.isHidden = true
        goButtton5.layer.isHidden = true
        self.loading.startAnimating()
        
        imgGet()
        
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func go(where: String) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: `where`)
        self.navigationController?.pushViewController(pushVC!, animated: true)
        print("go!")
    }


    
    func imgGet(){
        let apiURL = "http://13.209.4.65:3030/artist/list"
        let imgArray = [image1, image2, image3, image4, image5]
        let nameArray = [name1, name2, name3, name4, name5]
        
        
        AF.request(apiURL, method: .get, encoding: JSONEncoding.default).responseJSON() { [self] response in
                switch response.result {
                case .success(let response):
                    
                    
                    if let jsonObj = response as? NSDictionary
                    {
                        print("------------------")
                        print(jsonObj)
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("artist목록 불러오기 성공")
                            if let jsonObj = response as? NSDictionary{
                                
                               
                                let contentArray =  jsonObj.object(forKey: "content") as? NSArray
                                //print(contentArray)
                                
                                for i in 0...4 {
                                    let artist_list = contentArray![i]
                                    print(artist_list)
                                    
                                    let artist_name = (artist_list as AnyObject).object(forKey: "artist_name") as! String
                                    print(artist_name)
                                    
                                    let artist_url = (artist_list as AnyObject).object(forKey: "artist_url") as! String
                                    print(artist_url)
                                    
                                    let url = URL(string: artist_url)
                                    let data = try! Data(contentsOf: url!)
                                    imgArray[i]!.image = UIImage(data: data)
                                    self.urls.append(url!)
                                    
                                    
                                    nameArray[i]!.text = artist_name
                                }
                                print(nameArray)
                                
                                self.loading.stopAnimating()
                                self.loading.layer.isHidden = true

                                goButton.layer.isHidden = false
                                goButton2.layer.isHidden = false
                                goButton3.layer.isHidden = false
                                goButton4.layer.isHidden = false
                                goButtton5.layer.isHidden = false
                              
                            
                            }else{
                                print("artist목록 불러오기 오류")
                            }
                     
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
    
    
    
    
    @IBAction func goButtonAction(_ sender: Any) {
        
       print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        guard let vc =  storyboard?.instantiateViewController(identifier: "AddPhotoViewController") as? AddPhotoViewController else
                { return }
        
        vc.styleUrl = self.urls[0]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func goButton2Action(_ sender: Any) {
      
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        guard let vc =  storyboard?.instantiateViewController(identifier: "AddPhotoViewController") as? AddPhotoViewController else
                { return }
        
        vc.styleUrl = self.urls[1]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func goButton3Action(_ sender: Any) {
       
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        guard let vc =  storyboard?.instantiateViewController(identifier: "AddPhotoViewController") as? AddPhotoViewController else
                { return }
        
        vc.styleUrl = self.urls[2]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func goButton4Action(_ sender: Any) {
       
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        guard let vc =  storyboard?.instantiateViewController(identifier: "AddPhotoViewController") as? AddPhotoViewController else
                { return }
        
        vc.styleUrl = self.urls[3]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func goButton5Action(_ sender: Any) {
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        guard let vc =  storyboard?.instantiateViewController(identifier: "AddPhotoViewController") as? AddPhotoViewController else
                { return }
        
        vc.styleUrl = self.urls[4]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
     
    
}
