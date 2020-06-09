//
//  MainViewController.swift
//  Sign-in-with-Apple
//
//  Created by hiraoka on 2020/06/04.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import UIKit
import AuthenticationServices

class MainViewController: UIViewController {
    
    @IBOutlet weak var userIdentifierLabel: UILabel!
    @IBOutlet weak var givenNameLabel: UILabel!
    @IBOutlet weak var familyNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userIdentifierLabel.text = UserDefaults.standard.string(forKey: "userIdentifier")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
