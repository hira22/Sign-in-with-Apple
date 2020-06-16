//
//  SignInWithAppleIDButton.swift
//  Sign-in-with-Apple
//
//  Created by hiraoka on 2020/06/08.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import UIKit
import AuthenticationServices

@IBDesignable
class SignInWithAppleIDButton: UIButton {
    
    private var appleIDButton: ASAuthorizationAppleIDButton!
    
    @IBInspectable
    private var _cornerRadius: CGFloat = 6.0
    
    @IBInspectable
    private var type: Int = ASAuthorizationAppleIDButton.ButtonType.default.rawValue
    
    @IBInspectable
    private var style: Int = ASAuthorizationAppleIDButton.Style.black.rawValue
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let type = ASAuthorizationAppleIDButton.ButtonType.init(rawValue: self.type) ?? .default
        let style = ASAuthorizationAppleIDButton.Style.init(rawValue: self.style) ?? .black
        self.appleIDButton = ASAuthorizationAppleIDButton(authorizationButtonType: type, authorizationButtonStyle: style)
        self.appleIDButton.cornerRadius = _cornerRadius
        
        self.addSubview(appleIDButton)
        
        self.appleIDButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.appleIDButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.appleIDButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.appleIDButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.appleIDButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        appleIDButton.addTarget(self, action: #selector(appleIDButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func appleIDButtonTapped(_ sender: Any) {
        sendActions(for: .touchUpInside)
    }

}
