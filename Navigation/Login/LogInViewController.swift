//
//  LogInViewController.swift
//  Navigation
//
//  Created by Евгений Стафеев on 15.11.2022.
//

import UIKit
import FirebaseAuth

extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


class LogInViewController: UIViewController {
    
    let coordinator: ProfileCoordinator
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let vkLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let authorizationWindow: UIStackView = {
       let authWindow = UIStackView()
        authWindow.translatesAutoresizingMaskIntoConstraints = false
        authWindow.layer.borderColor = UIColor.lightGray.cgColor
        authWindow.layer.borderWidth = 0.5
        authWindow.layer.cornerRadius = 10
        authWindow.axis = .vertical
        authWindow.distribution = .fillEqually
        authWindow.clipsToBounds = true
        return authWindow
    }()
    let loginTextField: UITextField = {
        let login = UITextField()
        login.placeholder = NSLocalizedString(" Email or phone", comment: "")
        login.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        login.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray3)
        login.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        login.autocapitalizationType = .none
        login.layer.borderWidth = 0.5
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    let passwordTextField: UITextField = {
        let pass = UITextField()
        pass.placeholder = NSLocalizedString(" Password", comment: "")
        pass.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        pass.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray3)
        pass.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        pass.autocapitalizationType = .none
        pass.isSecureTextEntry = true
        pass.leftViewMode = .always
        pass.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        pass.translatesAutoresizingMaskIntoConstraints = false
        return pass
    }()
    
    
    let loginButton: CustomButton = {
        let loginButton = CustomButton(title: NSLocalizedString("Log in", comment: ""), titleColor: .white)
        let img1 = UIImage(named: "blue_pixel")!.alpha(1)
        let img2 = UIImage(named: "blue_pixel")!.alpha(0.8)
        loginButton.setBackgroundImage(img1, for: .normal)
        loginButton.setBackgroundImage(img2, for: .selected)
        loginButton.setBackgroundImage(img2, for: .highlighted)
        loginButton.setBackgroundImage(img2, for: .disabled)
        return loginButton
    }()
    
    var loginDelegate: LoginViewControllerDelegate?

    func tap() {
        guard let login = self.loginTextField.text, let pass = self.passwordTextField.text, !login.isEmpty, !pass.isEmpty else {
            AlertErrorSample.shared.alert(alertTitle: NSLocalizedString("Fill error", comment: ""), alertMessage: NSLocalizedString("Email and password fields must be filled", comment: ""))
            return
        }
        if self.loginDelegate?.delegateCheck(login: login, password: pass) == true {
            self.coordinator.startView()
        } else {
            return
        }
}
    
    let loginScrollView: UIScrollView = {
    let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        return scrollView
    }()
    
    let contentView = UIView()
    
    
    @objc func keyboardWillShow(Notification: NSNotification) {
        if let keyBoardSize = (Notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentInset.bottom = keyBoardSize.height
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardSize.height, right: 0)
        }
    }
    @objc func keyboardWillHide(Notification: NSNotification) {
        loginScrollView.contentInset.bottom = .zero
        loginScrollView.verticalScrollIndicatorInsets = .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        
        loginTextField.text = "1@1.ru"
        passwordTextField.text = "123456"
        
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        
        view.addSubview(loginScrollView)

        loginButton.actionHandler = { [weak self] in
            guard let self = self else { return }
            self.tap()
        }

        
        NSLayoutConstraint.activate([
        loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        loginScrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: loginScrollView.widthAnchor)
        ])
        
        contentView.addSubview(vkLogo)
        vkLogo.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        vkLogo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        vkLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(authorizationWindow)
        authorizationWindow.addArrangedSubview(loginTextField)
        authorizationWindow.addArrangedSubview(passwordTextField)
        authorizationWindow.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120).isActive = true
        authorizationWindow.heightAnchor.constraint(equalToConstant: 100).isActive = true
        authorizationWindow.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        authorizationWindow.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        contentView.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: authorizationWindow.bottomAnchor, constant: 16).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: authorizationWindow.leadingAnchor).isActive = true
        loginButton.rightAnchor.constraint(equalTo: authorizationWindow.rightAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            
        }
    }
