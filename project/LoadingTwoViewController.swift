//
//  LoadingTwoViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/30.
//

import UIKit
import Alamofire
class LoadingTwoViewController: UIViewController {

    
   
    
        @IBOutlet weak var loading: UIActivityIndicatorView!
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.loading.startAnimating()
            apiPost()
            
            
            // Do any additional setup after loading the view.
        }
        
        
        func apiPost(){
            let apiURL = "http://13.209.4.65:3030/model/test"
            
            AF.request(apiURL, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON() { [self] response in
                    switch response.result {
                    case .success(let response):
                        
                        
                        if let jsonObj = response as? NSDictionary
                        {
                            
                            let isSuccess = jsonObj.object(forKey: "isSuccess") as! Bool
                            
                            
                            if isSuccess == true{
                                print("로딩 호출 성공")
                                go(where: "ResultTwoViewController")
                            } else{
                                print("로딩 호출 실패")
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
}
