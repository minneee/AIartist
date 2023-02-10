//
//  ResultTwoViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/29.
//

import UIKit
import Alamofire

class ResultTwoViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func resultPost(){
        let apiURL = "http://13.209.4.65:3030/input/result/nst"
            
        let uName = UserDefaults.standard.string(forKey: "id")!
        let param: Parameters = ["userID": uName]
        AF.request(apiURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON() { [self] response in
                switch response.result {
                case .success(let response):
               
                    if let jsonObj = response as? NSDictionary
                    {
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("nst result 성공")
                            
                            let json = jsonObj.object(forKey: "content") as! NSDictionary
                            let jsonUrl = json.object(forKey: "url") as! String
                            let url = URL(string: jsonUrl)
                            let data = try! Data(contentsOf: url!)
                            image.image = UIImage(data: data)
                            print("이미지 가져오기")
                            
                            let tok = json.object(forKey: "token") as! Int
                            UserDefaults.standard.set(tok, forKey: "fileToken")
                                   
                            button.layer.isHidden = true
                        }else{
                            print("nst const 실패")
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
    
    func saveImg(name: String){
        let apiURL = "http://13.209.4.65:3030/save/result"
            
        let fileToken = UserDefaults.standard.string(forKey: "fileToken")!
        let fileName = name
        let param: Parameters = [
            "token": fileToken,
            "fileName": fileName]
        AF.request(apiURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON() { [self] response in
                switch response.result {
                case .success(let response):
               
                    if let jsonObj = response as? NSDictionary
                    {
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("nst result 성공")
                            
                            go(where: "HomeViewController")
                        }else{
                            print("nst const 실패")
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
    
    
    func go(where: String) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: `where`)
        self.navigationController?.pushViewController(pushVC!, animated: true)
        print("go!")
    }
    
    
    
    @IBAction func buttonAction(_ sender: Any) {
        resultPost()
        
    }
    
    
    @IBAction func homeButtonAction(_ sender: Any) {
        go(where: "HomeViewController")
    }
    
    
    func mes(){
        let nameAlert = UIAlertController(title: "이름 설정", message: "그림의 이름을 설정해주세요.", preferredStyle: UIAlertController.Style.alert)
            
        nameAlert.addTextField { textField in
            textField.placeholder = "이름을 입력하세요."
        }
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {
            ACTION in if let name = nameAlert.textFields?.first?.text {
                print(name)
                
                if name == "" {
                    let failAlert = UIAlertController(title: "경고", message: "이름을 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
                        
                    let failAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    
                    failAlert.addAction(failAction)
                    self.present(failAlert, animated: true, completion: nil)
                  
                    
                } else{
                    self.saveImg(name: name)
                    }
                }
            })
        
        
        nameAlert.addAction(okAction)

        self.present(nameAlert, animated: true, completion: nil)
    }
                                     
                                     
    
    @IBAction func saveButtonAction(_ sender: Any){
        mes()
        
    }
    
}
                                     
                                     
