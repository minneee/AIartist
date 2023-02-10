//
//  MyListViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/29.
//

import UIKit
import Alamofire

class MyListViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var image4: UIImageView!
    
    @IBOutlet weak var image5: UIImageView!
    
    @IBOutlet weak var image6: UIImageView!
    
    
    @IBOutlet weak var name1: UILabel!
    
    @IBOutlet weak var name2: UILabel!
    
    @IBOutlet weak var name3: UILabel!
    
    @IBOutlet weak var name4: UILabel!
    
    @IBOutlet weak var name5: UILabel!
    
    @IBOutlet weak var name6: UILabel!
    

    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var button6: UIButton!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var scroll: UIView!
    
    
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.layer.isHidden = true
        button2.layer.isHidden = true
        button3.layer.isHidden = true
        button4.layer.isHidden = true
        button5.layer.isHidden = true
        button6.layer.isHidden = true
        
     self.loading.startAnimating()
        myPost()
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func myPost() {
        let nameArray = [name1, name2, name3, name4, name5, name6]
        let btnArray = [button1, button2, button3, button4, button5, button6]
        let imgArray = [image1, image2, image3, image4, image5, image6]

        // 1. 전송할 값 준비
        let apiURL = "http://13.209.4.65:3030/art/list"
            
        let uId = UserDefaults.standard.string(forKey: "id")!
        let param: Parameters = ["userID": uId]
        AF.request(apiURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON() { [self] response in
                switch response.result {
                case .success(let response):
                    
                    
                    if let jsonObj = response as? NSDictionary
                    {
                        print("------------------")
                        print(jsonObj)
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("작품 불러오기 성공")
                            
                            if let jsonObj = response as? NSDictionary{
                                
                               
                                let contentArray =  jsonObj.object(forKey: "content") as? NSArray
                                //print(contentArray)
                                let num = contentArray?.count as! Int
                                if num == 0{
                                    name1.text = "작품이 존재하지 않습니다."
                                }else{
                                    for i in 0...(num-1) {
                                        let art_list = contentArray![i]
                                        print(art_list)
                                        
                                        let art_name = (art_list as AnyObject).object(forKey: "art_filename") as! String
                                        print(art_name)
                                        
                                        let art_url = (art_list as AnyObject).object(forKey: "art_url") as! String
                                        print(art_url)
                                        
                                        let url = URL(string: art_url)
                                        let data = try! Data(contentsOf: url!)
                                        imgArray[i]!.image = UIImage(data: data)
                                        
                                        
                                        
                                        nameArray[i]!.text = art_name
                                        btnArray[i]!.layer.isHidden = false
                                        
                                    }
                                }
                                print(nameArray)
                                
                                self.loading.stopAnimating()
                                self.loading.layer.isHidden = true

                                
                        } else{
                            print("작품 불러오기 실패")
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
    
    
    func deletePost(name: String){
        let apiURL = "http://13.209.4.65:3030/art/del"
            
        let artName = name
        let param: Parameters = ["artName": artName]
        AF.request(apiURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON() { [self] response in
                switch response.result {
                case .success(let response):
                    
                    
                    if let jsonObj = response as? NSDictionary
                    {
                        print("------------------")
                        print(jsonObj)
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("작품 삭제 성공")
                            mes()
                            
                        }else{
                            print("작품 삭제 실패")
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
    
    func del(){
        //scroll.clearsContextBeforeDrawing = true
        scroll.removeFromSuperview()
        self.loading.layer.isHidden = false
        self.loading.startAnimating()
        myPost()
    }
    
    func mes(){
        let sAlert = UIAlertController(title: "삭제", message: "삭제 되었습니다.", preferredStyle: UIAlertController.Style.alert)
            
        let s1Action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {
            ACTION in self.navigationController?.popViewController(animated: true)

            
        })
        
        sAlert.addAction(s1Action)
        self.present(sAlert, animated: true, completion: nil)
    }
        
        
    let flagImageSave = true
    
    @IBAction func button1Action(_ sender: Any) {
      
        let plusAlert = UIAlertController(title: "더보기", message: "아래 버튼을 클릭해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        let Action1 = UIAlertAction(title: "저장", style: UIAlertAction.Style.default, handler: {
            ACTION in if self.flagImageSave {
                UIImageWriteToSavedPhotosAlbum(self.image1.image!, self, nil, nil)
            }
        })
        
        let Action2 = UIAlertAction(title: "삭제", style: UIAlertAction.Style.default, handler: {
            ACTION in self.deletePost(name: self.name1.text!)
        })
        
        let Action3 = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        
        
        plusAlert.addAction(Action1)
        plusAlert.addAction(Action2)
        plusAlert.addAction(Action3)
        self.present(plusAlert, animated: true, completion: nil)
        }
    
    
    @IBAction func button2Action(_ sender: Any) {
      
        let plusAlert = UIAlertController(title: "더보기", message: "아래 버튼을 클릭해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        let Action1 = UIAlertAction(title: "저장", style: UIAlertAction.Style.default, handler: {
            ACTION in if self.flagImageSave {
                UIImageWriteToSavedPhotosAlbum(self.image1.image!, self, nil, nil)
            }
        })
        
        let Action2 = UIAlertAction(title: "삭제", style: UIAlertAction.Style.default, handler: {
            ACTION in self.deletePost(name: self.name2.text!)
        })
        
        let Action3 = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        
        
        plusAlert.addAction(Action1)
        plusAlert.addAction(Action2)
        plusAlert.addAction(Action3)
        self.present(plusAlert, animated: true, completion: nil)
        }
    
    
    @IBAction func button3Action(_ sender: Any) {
      
        let plusAlert = UIAlertController(title: "더보기", message: "아래 버튼을 클릭해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        let Action1 = UIAlertAction(title: "저장", style: UIAlertAction.Style.default, handler: {
            ACTION in if self.flagImageSave {
                UIImageWriteToSavedPhotosAlbum(self.image1.image!, self, nil, nil)
            }
        })
        
        let Action2 = UIAlertAction(title: "삭제", style: UIAlertAction.Style.default, handler: {
            ACTION in self.deletePost(name: self.name3.text!)
        })
        
        let Action3 = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        
        
        plusAlert.addAction(Action1)
        plusAlert.addAction(Action2)
        plusAlert.addAction(Action3)
        self.present(plusAlert, animated: true, completion: nil)
        }
    
    
    @IBAction func button4Action(_ sender: Any) {
      
        let plusAlert = UIAlertController(title: "더보기", message: "아래 버튼을 클릭해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        let Action1 = UIAlertAction(title: "저장", style: UIAlertAction.Style.default, handler: {
            ACTION in if self.flagImageSave {
                UIImageWriteToSavedPhotosAlbum(self.image1.image!, self, nil, nil)
            }
        })
        
        let Action2 = UIAlertAction(title: "삭제", style: UIAlertAction.Style.default, handler: {
            ACTION in self.deletePost(name: self.name4.text!)
        })
        
        let Action3 = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        
        
        plusAlert.addAction(Action1)
        plusAlert.addAction(Action2)
        plusAlert.addAction(Action3)
        self.present(plusAlert, animated: true, completion: nil)
        }
    
    
    
    @IBAction func button5Action(_ sender: Any) {
      
        let plusAlert = UIAlertController(title: "더보기", message: "아래 버튼을 클릭해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        let Action1 = UIAlertAction(title: "저장", style: UIAlertAction.Style.default, handler: {
            ACTION in if self.flagImageSave {
                UIImageWriteToSavedPhotosAlbum(self.image1.image!, self, nil, nil)
            }
        })
        
        let Action2 = UIAlertAction(title: "삭제", style: UIAlertAction.Style.default, handler: {
            ACTION in self.deletePost(name: self.name5.text!)
        })
        
        let Action3 = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        
        
        plusAlert.addAction(Action1)
        plusAlert.addAction(Action2)
        plusAlert.addAction(Action3)
        self.present(plusAlert, animated: true, completion: nil)
        }
    
    
    
    @IBAction func button6Action(_ sender: Any) {
      
        let plusAlert = UIAlertController(title: "더보기", message: "아래 버튼을 클릭해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        let Action1 = UIAlertAction(title: "저장", style: UIAlertAction.Style.default, handler: {
            ACTION in if self.flagImageSave {
                UIImageWriteToSavedPhotosAlbum(self.image1.image!, self, nil, nil)
            }
        })
        
        let Action2 = UIAlertAction(title: "삭제", style: UIAlertAction.Style.default, handler: {
            ACTION in self.deletePost(name: self.name6.text!)
        })
        
        let Action3 = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        
        
        plusAlert.addAction(Action1)
        plusAlert.addAction(Action2)
        plusAlert.addAction(Action3)
        self.present(plusAlert, animated: true, completion: nil)
        }
        
    
}
