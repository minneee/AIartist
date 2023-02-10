//
//  MenuViewController.swift
//  project
//
//  Created by 김민희 on 2021/10/10.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var myListButton: UIButton!
    
    @IBOutlet weak var aiListButton: UIButton!
    
    @IBOutlet weak var guidButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var userIdLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userIdLabel.text = UserDefaults.standard.string(forKey: "id")!
    }
    
    @IBAction func myListButtonAction(_ sender: Any) {
        go(where: "MyListViewController")
    }
    
    
    @IBAction func aiListButtonAction(_ sender: Any) {
        go(where: "AiListViewController")
    }
    
    
    @IBAction func guidButtonAction(_ sender: Any) {
        go(where: "GuidViewController")
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) { 
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        
        go(where: "FirstViewController")
    }
    
    
    
    func go(where: String) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: `where`)
        self.navigationController?.pushViewController(pushVC!, animated: true)
        print("go!")
    }

}
