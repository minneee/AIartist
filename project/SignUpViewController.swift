//
//  SignUpViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/08.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var backButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func SignUpButtonActon(_ sender: Any) {
        
        print("회원가입 버튼 글릭")
        signUpPost()
        
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func goToViewController(where: String) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: `where`)
        self.navigationController?.pushViewController(pushVC!, animated: true)
        print("go!")
    }
    
    
  
    func signUpPost() {
        
        // 1. 전송할 값 준비
        let apiURL = "http://13.209.4.65:3030/join"
        let uId = idTextField.text
        let uPW = pwTextField.text
        let uEMAIL = emailTextField.text
            let param: Parameters = [
                "userID": uId,
                "userPW": uPW,
                "userEMAIL": uEMAIL]
        AF.request(apiURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON() { response in
                switch response.result {
                case .success(let response):
                    
                    
                    if let jsonObj = response as? NSDictionary
                    {
                        print("------------------")
                        print(jsonObj)
                        let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                        
                        
                        if isSuccess == true{
                            print("회원가입 성공")
                            self.goToViewController(where: "HomeViewController")
                            
                            let content = jsonObj.object(forKey: "content") as? NSDictionary
                            let id = content?.object(forKey: "ID") as! String
                            
                            UserDefaults.standard.set(id, forKey: "id")
                            
                            
                        }else{
                            print("회원가입 오류")
                            
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
                                    print("이메일을 입력하세요")
                                    msg()
                                    
                                }else if code == 304{
                                    print("이미 존재하는 아이디")
                                    msg()
                                    
                                }else if code == 305{
                                    print("이미 존재하는 이메일")
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

