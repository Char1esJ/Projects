//
//  ProfileViewController.swift
//  Project
//
//  Created by kv on 15.11.25.
//

import UIKit
import UIComponents
import Core

class ProfileViewController: UIViewController {

    private let viewModel: ProfileViewModel
    
    private let profileImages = ["PictureN1", "PictureN2", "PictureN3", "PictureN4", "PictureN5", "PictureN6"]
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "profile.title".localized
        label.font = UIFont(name: "Inter", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let profilePictureContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ProfilePictureImage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 60
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let blackOverlay: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return v
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "CameraIcon"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let fullNameField = NameField(label: "profile.fullname.label".localized, placeholder: "Enter Fullname")
    private let usernameField = NameField(label: "profile.username.label".localized, placeholder: "Enter Username")
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "profile.language".localized
        label.font = UIFont(name: "Inter", size: 14)
        label.textColor = UIColor(red: 0.502, green: 0.502, blue: 0.502, alpha: 0.55)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var languageToggle: LanguageToggleView = {
        let toggle = LanguageToggleView()
        toggle.delegate = self
        return toggle
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("profile.logout".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 1.0)
        button.titleLabel?.font = UIFont(name: "Inter", size: 20)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setVCBackground()
        
        setupUI()
        setupLocalizationObserver()
        updateLanguageToggle()
        loadProfile()
        setupActions()
    }
    
    private func setupUI() {
        navigationItem.title = "profile.title".localized
        
        let saveButton = UIBarButtonItem(
            title: "profile.save".localized,
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        
        saveButton.tintColor = UIColor(red: 81/255,green: 89/255,blue: 246/255,alpha: 1.0)

        navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -34),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -34)
        ])
        
        setupProfilePicture()
        contentStackView.addArrangedSubview(profilePictureContainer)
        contentStackView.setCustomSpacing(32, after: profilePictureContainer)
        
        contentStackView.addArrangedSubview(fullNameField)
        contentStackView.addArrangedSubview(usernameField)
        contentStackView.setCustomSpacing(41, after: usernameField)
        
        contentStackView.addArrangedSubview(languageLabel)
        contentStackView.setCustomSpacing(12, after: languageLabel)
        contentStackView.addArrangedSubview(languageToggle)
        
        scrollView.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: languageToggle.bottomAnchor, constant: 192),
            logoutButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 40),
            logoutButton.widthAnchor.constraint(equalToConstant: 128),
            logoutButton.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: -40),
        ])
    }
    
    private func setupProfilePicture() {
        profilePictureContainer.addSubview(profileImageView)
        profilePictureContainer.addSubview(cameraButton)

        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: profilePictureContainer.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: profilePictureContainer.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            profilePictureContainer.heightAnchor.constraint(equalToConstant: 120)
        ])

        profileImageView.addSubview(blackOverlay)
        NSLayoutConstraint.activate([
            blackOverlay.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            blackOverlay.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            blackOverlay.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            blackOverlay.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cameraButton.widthAnchor.constraint(equalToConstant: 56),
            cameraButton.heightAnchor.constraint(equalToConstant: 56),
            cameraButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            cameraButton.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func saveButtonTapped() {
        let fullname = fullNameField.textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let username = usernameField.textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        viewModel.saveUserInfo(fullname: fullname, username: username) { [weak self] success, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showUpdateError(on: self, with: error)
                return
            }
            
            if success {
                self.fullNameField.textField.text = ""
                self.usernameField.textField.text = ""
                self.updateUserFields()
                AlertManager.showUpdateSuccess(on: self)
            }
        }
    }
    
    @objc private func profileImageTapped() {
        let alert = UIAlertController(title: "profile.choose.picture".localized, message: "\n\n\n\n\n", preferredStyle: .alert)
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        alert.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60),
            scrollView.widthAnchor.constraint(equalToConstant: 250),
            scrollView.heightAnchor.constraint(equalToConstant: 70),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        for imageName in profileImages {
            let button = UIButton()
            button.setImage(UIImage(named: imageName), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.layer.cornerRadius = 35
            button.clipsToBounds = true
            button.tag = profileImages.firstIndex(of: imageName) ?? 0
            button.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
            
            button.widthAnchor.constraint(equalToConstant: 70).isActive = true
            button.heightAnchor.constraint(equalToConstant: 70).isActive = true
            
            stackView.addArrangedSubview(button)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func imageButtonTapped(_ sender: UIButton) {
        let imageName = profileImages[sender.tag]
        selectProfileImage(imageName: imageName)
        dismiss(animated: true)
    }
    
    private func updateLanguageToggle() {
        let isGeorgian = LocalizationManager.shared.currentLanguage == .georgian
        languageToggle.setLanguage(isGeorgian: isGeorgian)
    }
    
    @objc private func logoutButtonTapped() {
        viewModel.logoutTapped(from: self)
    }
    
    private func loadProfile() {
        viewModel.loadProfile { [weak self] user in
            guard let self = self else { return }
            
            if user == nil {
                print("Failed to load user")
            }
            
            self.updateUserFields()
        }
    }
    
    private func selectProfileImage(imageName: String) {
        if let image = UIImage(named: imageName) {
            profileImageView.image = image
            viewModel.selectedImageName = imageName

            cameraButton.isHidden = true
            blackOverlay.isHidden = true
        }
    }
    
    private func updateUserFields() {
        guard let user = viewModel.currentUser else { return }
        fullNameField.textField.text = user.fullname
        usernameField.textField.text = user.username
        
        if let imageName = user.profileImageName,
           let image = UIImage(named: imageName) {
            profileImageView.image = image

           
            cameraButton.isHidden = true
            blackOverlay.isHidden = true
        }
    }
}

extension ProfileViewController: Localizable {
    func updateLocalizedStrings() {
        navigationItem.title = "profile.title".localized
        titleLabel.text = "profile.title".localized
        
        navigationItem.rightBarButtonItem?.title = "profile.save".localized
        
        fullNameField.updateLanguage(
            label: "profile.fullname.label".localized,
            placeholder: "auth.fullname.placeholder".localized
        )
        
        usernameField.updateLanguage(
            label: "profile.username.label".localized,
            placeholder: "auth.username.label".localized
        )
        
        updateUserFields()
        
        languageLabel.text = "profile.language".localized
        logoutButton.setTitle("profile.logout".localized, for: .normal)
        updateLanguageToggle()
    }
}

extension ProfileViewController: LanguageToggleViewDelegate {
    func languageToggleViewDidChangeLanguage(_ view: LanguageToggleView) {
        let currentLanguage = LocalizationManager.shared.currentLanguage
        LocalizationManager.shared.currentLanguage = currentLanguage == .english ? .georgian : .english
    }
}
