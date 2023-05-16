//
//  InfoViewController.swift
//  Navigation
//
//  Created by Евгений Стафеев on 01.11.2022.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("AlertButton", for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let jsonLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jsonLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.backgroundColor = .darkGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(alertButton)
        view.addSubview(jsonLabel1)
        view.addSubview(jsonLabel2)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            alertButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            jsonLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            jsonLabel1.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 16),
            jsonLabel1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            jsonLabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            jsonLabel2.topAnchor.constraint(equalTo: jsonLabel1.bottomAnchor, constant: 16),
            jsonLabel2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: jsonLabel2.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    var residents: [String] = []
    var residentsName: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.textLabel?.text = self.residentsName[indexPath.row]
        return cell
    }
    
    @objc func tap() {
        let alertVC = UIAlertController(title: "Alert", message: "Внимание! Вернутся обратно?", preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in print("Is's OK")})
        let actionTwo = UIAlertAction(title: "Cancel", style: .default, handler: {(UIAlertAction) in print("Is's Cancel")})
        alertVC.addAction(actionOne)
        alertVC.addAction(actionTwo)
        self.present(alertVC, animated: true, completion: nil)
    }
}

class TableViewCell: UITableViewCell {

}
