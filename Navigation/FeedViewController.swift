//
//  FeedViewController.swift
//  Navigation
//
//  Created by Евгений Стафеев on 01.11.2022.
//

import UIKit


class FeedViewController: UIViewController {
    
    let postFeed: PostFeed = .init(title: "Hello world")
    
    let newStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var button1: CustomButton = {
        let button1 = CustomButton(title: "Post", titleColor: .black)
        button1.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button1.tag = 0
        button1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return button1
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Секретное слово"
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Кнопка проверки пароля", titleColor: .black)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    let checkLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()

    var model = FeedModel()
    
    func sendText() {
        checkGuessButton.actionHandler = { [self] in
            if let text = textField.text {
                if model.check(word: text) == true {
                    checkLabel.backgroundColor = .green
                }
                else {
                    checkLabel.backgroundColor = .red
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(newStackView)
        view.addSubview(textField)
        view.addSubview(checkGuessButton)
        view.addSubview(checkLabel)
        sendText()
        
    }

    @objc func tap() {
        let postVC = PostViewController()
        postVC.title = postFeed.title
        navigationController?.pushViewController(postVC, animated: true)
    }
    override func viewWillLayoutSubviews() {
        newStackView.addArrangedSubview(button1)
    
        NSLayoutConstraint.activate([
            newStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            checkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkLabel.widthAnchor.constraint(equalTo: checkGuessButton.widthAnchor),
            checkLabel.heightAnchor.constraint(equalTo: checkGuessButton.heightAnchor)
            
        ])
        
    }
}

class FeedModel {
    let secretWord = "Нетология"
    func check(word: String) -> Bool { word == secretWord }
}
