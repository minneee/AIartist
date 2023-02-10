//
//  LoginViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/06.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func loginButtonAction(_ sender: Any) {
        
        print("로그인 버튼 클릭")
        logInPost()
     
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func goToViewController(where: String) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: `where`)
        self.navigationController?.pushViewController(pushVC!, animated: true)
        print("go!")
    }
    
    
    
    
    
    
    func logInPost() {
        
            // 1. 전송할 값 준비
            let apiURL = "http://13.209.4.65:3030/login"
            
        let uId = idTextField.text
        let uPW = pwTextField.text
            let param: Parameters = [
                "userID": uId,
                "userPW": uPW]
        AF.request(apiURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON() { response in
                switch response.result {
                case .success(let response):
                    
                    
                    if let jsonObj = response as? NSDictionary
                    {
                        print("------------------")
                        print(jsonObj)
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("로그인 성공")
                            self.goToViewController(where: "HomeViewController")
                            
                            
                            let content = jsonObj.object(forKey: "content") as? NSDictionary
                            let id = content?.object(forKey: "ID") as! String
                            
                            UserDefaults.standard.set(id, forKey: "id")
                            
                           //print(UserDefaults.standard.string(forKey: "id")!)
                            
                        }else{
                            print("로그인 오류")
                            
                            if let jsonObj = response as? NSDictionary{
                                
                                let code = jsonObj.object(forKey: "code") as! Int
                                let message = jsonObj.object(forKey: "message") as! String
                                
                                if code == 301{
                                    print("아이디를 입력하세요")
                                    msg()
                                    
                                }else if code == 302{
                                    print("비밀번호를 입력하세요")
                                    msg()
                                    
                                }else if code == 303{
                                    print("아이디 또는 비밀번호를 확인해주세요")
                                    msg()
                                    
                                }
                                func msg(){
                                    let signUpFailAlert = UIAlertController(title: "경고", message: message, preferredStyle: UIAlertController.Style.alert)
                                    
                                    let signUpFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                                    signUpFailAlert.addAction(signUpFailAction)
                                    self.present(signUpFailAlert, animated: true, completion: nil)
                                    
                                }
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
    
    
    
    
    
    
    
    
}
