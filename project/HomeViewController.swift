//
//  HomeViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/10.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func menuButtonAction(_ sender: Any) {
        print("메뉴 클릭")
        goToViewController(where: "MenuViewController")
        
    }
    
    
    @IBAction func startButtonAction(_ sender: Any) {
        goToViewController(where: "StartOptionViewController")
    }
    
    
    
    
    func goToViewController(where: String) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: `where`)
        self.navigationController?.pushViewController(pushVC!, animated: true)
        print("go!")
    }
    
}
