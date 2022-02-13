//
//  ViewController.swift
//  KakaoSignUp
//
//  Created by Ki Hyun on 2022/02/13.
//

import UIKit
import KakaoSDKUser

class ViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        logoutBtn.isEnabled = false
    }
    
    @IBAction func KakaoLoginBtn(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                self.loginBtn.isEnabled = false
                self.logoutBtn.isEnabled = true
                //do something
                _ = oauthToken
                self.setUesrInfo()
                
            }
        }
    }

    
    @IBAction func KakaoLogout(_ sender: Any) {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                self.profileName.text = ""
                self.profileImage.image = nil
                self.loginBtn.isEnabled = true
                self.logoutBtn.isEnabled = false
                
            }
        }
    }
    
    func setUesrInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                self.profileName.text = user?.kakaoAccount?.profile?.nickname
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                    let data = try? Data(contentsOf: url) {
                    self.profileImage.image = UIImage(data: data)
                }
            }
        }
    
    }
}

