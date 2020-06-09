//
//  ViewController.swift
//  Sign-in-with-Apple
//
//  Created by hiraoka on 2020/06/04.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func handleAuthAppleID(_ sender: SignInWithAppleIDButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

}

extension ViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            dump(appleIDCredential.authorizationCode)
            dump(appleIDCredential.identityToken)
            dump(appleIDCredential.state)
            dump(appleIDCredential.user)
            dump(appleIDCredential.authorizedScopes)
            dump(appleIDCredential.fullName)
            dump(appleIDCredential.email)
            dump(appleIDCredential.realUserStatus)
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            UserDefaults.standard.set(userIdentifier, forKey: "userIdentifier")
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            guard let viewController = self.presentingViewController as? MainViewController else { return }
            DispatchQueue.main.async {
                viewController.userIdentifierLabel.text = userIdentifier
                viewController.givenNameLabel.text = fullName?.givenName
                viewController.familyNameLabel.text = fullName?.familyName
                viewController.emailLabel.text = email
                self.dismiss(animated: true, completion: nil)
            }
            
        case let passwordCredential as ASPasswordCredential:
            dump(passwordCredential)
            
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
}

