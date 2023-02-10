//
//  FirstViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/27.
//

import UIKit

class FirstViewController: UIViewController {

    
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        print("로그인으로 이동")
        goToViewController(where: "LoginViewController")

    }
    
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        print("회원가입으로 이동")
        goToViewController(where: "SignUpViewController")
    }
    
    
    func goToViewController(where: String) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: `where`)
        self.navigationController?.pushViewController(pushVC!, animated: true)
        print("go!")
    }
}
