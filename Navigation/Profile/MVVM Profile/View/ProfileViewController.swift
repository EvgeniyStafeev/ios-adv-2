//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Евгений Стафеев on 26.01.2023.
//

import UIKit

import FirebaseAuth


class ProfileViewController: UIViewController {
    
    let tableView = UITableView.init(frame: .zero, style: .grouped)
    let profileViewModel: ProfileViewModel
    let photoCoordinator: PhotoCoordinator
    let coreDataService = CoreDataService()
    
    init(photoCoordinator: PhotoCoordinator, profileViewModel: ProfileViewModel) {
        self.photoCoordinator = photoCoordinator
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
//    let profileHeaderView = ProfileHeaderView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var timeOutCounter = 100
    var timer: Timer?
    
    var backgroundView: UIView = {
    let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var closeBtn: UIButton = {
        let closeBtn = UIButton()
        let img1 = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        closeBtn.setImage(img1, for: .normal)
        closeBtn.tintColor = .white
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.alpha = 0
        closeBtn.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        return closeBtn
    }()
    
    
    
    func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        backgroundView.addSubview(profileViewModel.profileHeaderView.avatarImageView)
        
        backgroundView.addSubview(closeBtn)
        closeBtn.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        closeBtn.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15).isActive = true
    }
    
    @objc private func tapProcess() {
        let avatar = profileViewModel.profileHeaderView.avatarImageView
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.setupBackgroundView()
            if UIDevice.current.orientation.isPortrait{
            NSLayoutConstraint.activate([
                avatar.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                avatar.heightAnchor.constraint(equalTo: self.view.widthAnchor),
                avatar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                avatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])
            }
            else {
                NSLayoutConstraint.activate([
                    avatar.widthAnchor.constraint(equalTo: self.view.heightAnchor),
                    avatar.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                    avatar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    avatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                ])
            }
            self.view.layoutIfNeeded()
        } completion: { finished in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.closeBtn.alpha = 1
                self.profileViewModel.profileHeaderView.avatarImageView.layer.cornerRadius = 0
            }
        }
    }
    

    @objc private func closeAvatar() {

        print("closed")
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.closeBtn.alpha = 0
            self.profileViewModel.profileHeaderView.avatarImageView.layer.cornerRadius = 110/2
            self.view.layoutIfNeeded()
        } completion: { finished in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.profileViewModel.profileHeaderView.addSubview(self.profileViewModel.profileHeaderView.avatarImageView)
                
                self.profileViewModel.profileHeaderView.avatarImageView.leftAnchor.constraint(equalTo: self.profileViewModel.profileHeaderView.leftAnchor, constant: 16).isActive = true
                self.profileViewModel.profileHeaderView.avatarImageView.topAnchor.constraint(equalTo: self.profileViewModel.profileHeaderView.topAnchor, constant: 16).isActive = true
                self.profileViewModel.profileHeaderView.avatarImageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
                self.profileViewModel.profileHeaderView.avatarImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
                self.backgroundView.removeFromSuperview()
    
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray3)
        #if DEBUG
        view.backgroundColor = .red
        #endif
        
        self.title = "Profile".localized
        view.addSubview(tableView)
        profileViewModel.setUser()
        profileViewModel.setPosts()
        setupTableView()
//        createTimer()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        //Если выходим с профиля - считаем что пользователь разлогинелся
        do {
            try Auth.auth().signOut()
            CheckerService.shared.isSingIn = false
        } catch {
            print("Неизвестная ошибка")
        }
    }
    
    func setupTableView() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            return profileViewModel.postsData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            cell.post = profileViewModel.postsData[indexPath.row]
            let tap = UITapGestureRecognizer(target: self, action: #selector(addPost))
            tap.numberOfTapsRequired = 2
            cell.addGestureRecognizer(tap)
            return cell
        }
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            photoCoordinator.startView()
        }
    }
    
    @objc func addPost(_ sender: UITapGestureRecognizer) {
        guard let indexPath = tableView.indexPathForRow(at: sender.location(in: self.tableView)) else {return}
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.post = profileViewModel.postsData[indexPath.row]
//        CoreDataService.coreManager.persistentContainer.viewContext.save()
        coreDataService.saveContext(
            postModel: .init(
                author: profileViewModel.postsData[indexPath.row].author,
                postDescription: profileViewModel.postsData[indexPath.row].postDescription,
                image: profileViewModel.postsData[indexPath.row].image,
                likes: profileViewModel.postsData[indexPath.row].likes,
                views: profileViewModel.postsData[indexPath.row].views)
        )
    }
}
    
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapProcess))
            self.profileViewModel.profileHeaderView.avatarImageView.addGestureRecognizer(tapGesture)
            return profileViewModel.profileHeaderView
        }
        else {
            return nil
        }
    }
}
