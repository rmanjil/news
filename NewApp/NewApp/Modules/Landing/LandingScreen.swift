//
//  LandingView.swift
//  MVVMC
//
//  Created by manjil on 3/26/20.
//  
//

import UIKit

class DesignTextfield: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white.withAlphaComponent(0.14)
        tintColor = .white
        textColor = .white
        createLeftView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLeftView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 15))
        leftViewMode = .always
        leftView = view
        
    }
}


final class LandingScreen: AppBaseView {
    
    private(set) lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.distribution = .fill
        stack.axis = .vertical
      //  stack.alignment = .trailing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) lazy var appLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "News"
        label.textColor = .white
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WelCome Back".uppercased()
        label.textAlignment = .center
        label.font =  .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    /// the login with email
    private(set) lazy var loginWithEmailButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.clipsToBounds = true
        return button
    }()
    
    private(set) lazy var emailField: DesignTextfield = {
        let field = DesignTextfield()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 30
        field.keyboardType = .emailAddress
        field.textContentType = .emailAddress
        field.attributedPlaceholder  =  "Your Email".attributeText(attribute: [.foregroundColor: UIColor.white.withAlphaComponent(0.8)])
        return field
    }()
    
    private(set) lazy var passwordField: DesignTextfield = {
        let field = DesignTextfield()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 30
        field.isSecureTextEntry = true
        field.attributedPlaceholder = "Password".attributeText(attribute: [.foregroundColor: UIColor.white.withAlphaComponent(0.8)])
        return field
    }()
    
    private(set) lazy var passwordForgotButton: UIButton = {
        let button = UIButton()
        button.setTitle("forgot password?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
 
    
    
    override func createDesign() {
        backgroundColor = .gray
        
        generateChildren()
    }
    
    
    
}

extension LandingScreen {

    /// Generates the child views of self
    private func generateChildren() {
       
        addSubview(stack)
        //addSubview(emailField)
        stack.addArrangedSubview(appLabel)
        stack.setCustomSpacing(32, after: appLabel)
        stack.addArrangedSubview(welcomeLabel)
        stack.setCustomSpacing(32, after: welcomeLabel)
        stack.addArrangedSubview(emailField)
        stack.addArrangedSubview(passwordField)
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(view)
        view.addSubview(passwordForgotButton)
        
        //addSubview(loginWithEmailButton)
        stack.addArrangedSubview(loginWithEmailButton)
        
        
        NSLayoutConstraint.activate([
            
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
          //  stack.topAnchor.constraint(greaterThanOrEqualTo: logoImage.bottomAnchor, constant:  isIPhone ? 32: 16),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
           
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            emailField.heightAnchor.constraint(equalToConstant: 60),
            passwordField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordForgotButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            passwordForgotButton.topAnchor.constraint(equalTo: view.topAnchor),
            passwordForgotButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            passwordForgotButton.heightAnchor.constraint(equalToConstant: 40),
            passwordForgotButton.widthAnchor.constraint(equalToConstant: 150),
            
            loginWithEmailButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
