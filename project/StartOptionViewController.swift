//
//  StartOptionViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/29.
//

import UIKit

class StartOptionViewController: UIViewController {

    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var Button1: UIButton!
    
    
    @IBOutlet weak var Button2: UIButton!
    
    @IBOutlet weak var Button3: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Button1Action(_ sender: Any) {
        go(where: "AiListViewController")
    }
    
    
    @IBAction func Button2Action(_ sender: Any) {
        go(where: "AddPhotoViewController")
    }
    
    
    @IBAction func Button3Action(_ sender: Any) {
        go(where: "AddObjViewController")
    }
    
    
    
    
    func go(where: String) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: `where`)
        self.navigationController?.pushViewController(pushVC!, animated: true)
        print("go!")
    }
    
    
    
    
}
