//
//  AddNewCardPage.swift
//  Assignment-N17
//
//  Created by Charles Janjgava on 10/15/25.
//

import UIKit

protocol AddCardDelegate: AnyObject {
    func addCard(newCard: WuwuniModel)
}

class AddNewCardPageVC: UIViewController {
    // MARK: Properties
    weak var delegate: AddCardDelegate?
    
    private var icon: UIImage?
    
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackgrroundColorImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var textContainerOne: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var textContainerTwo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var iconContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var iconStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // Icon Buttons
    private lazy var redButton = createIconButton(image: "RedIcon", selectedOrNot: true)
    private lazy var purpleButton = createIconButton(image: "PurpleIcon", selectedOrNot: false)
    private lazy var greenButton = createIconButton(image: "GreenIcon", selectedOrNot: false)
    private lazy var yellowButton = createIconButton(image: "YellowIcon", selectedOrNot: false)
        
    private let addButton: UIButton = {
        let button = UIButton()
        let screenHeight = UIScreen.main.bounds.height
        button.layer.cornerRadius = screenHeight * 0.012
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "AddButton")
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: screenHeight * 0.018, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabelOne: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.019, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabelTwo: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.019, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textFieldOne: UITextField = {
        let textField = UITextField()
        let screenHeight = UIScreen.main.bounds.height
        textField.font = .systemFont(ofSize: screenHeight * 0.015)
        textField.placeholder = "eg. panic, need help"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 0.6
        textField.layer.cornerRadius = screenHeight * 0.0067
        textField.textAlignment = .left
        textField.textColor = .label
        textField.backgroundColor = UIColor(named: "TextFieldColor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let textFieldTwo: UITextField = {
        let textField = UITextField()
        let screenHeight = UIScreen.main.bounds.height
        textField.font = .systemFont(ofSize: screenHeight * 0.015)
        textField.placeholder = "eg. can't merge pull request, we have a conflict"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 0.6
        textField.layer.cornerRadius = screenHeight * 0.0067
        textField.textAlignment = .left
        textField.textColor = .label
        textField.backgroundColor = UIColor(named: "TextFieldColor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let chooseIconLabel: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.text = "Choose Icon"
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.019, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        wrapInBorder(redButton)
    }
    
    // MARK: Methods
    private func setupView() {
        setupBackgroundImage()
        setupStackView()
        configureAddButton()
        buttonAction()
    }
    
    private func setupStackView() {
        configureMainStackView()
        configureContainerViews()
    }
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.bounds
    }
    
    private func configureMainStackView() {
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
        ])
    }
    
    private func configureContainerViews() {
        let screenHeight = UIScreen.main.bounds.height
        mainStackView.addArrangedSubview(textContainerOne)
        mainStackView.addArrangedSubview(textContainerTwo)
        configureHorizontalStackView()
        
        NSLayoutConstraint.activate([
            textContainerOne.heightAnchor.constraint(equalToConstant: screenHeight * 0.105),
            textContainerTwo.heightAnchor.constraint(equalToConstant: screenHeight * 0.16),
        ])
    }
    
    private func configureTexts() {
        let screenHeight = UIScreen.main.bounds.height
        textContainerOne.addSubview(titleLabelOne)
        textContainerOne.addSubview(textFieldOne)
        
        textContainerTwo.addSubview(titleLabelTwo)
        textContainerTwo.addSubview(textFieldTwo)
        textContainerTwo.addSubview(chooseIconLabel)
        
        NSLayoutConstraint.activate([
            // Label 1 and TextField 1
            titleLabelOne.topAnchor.constraint(equalTo: textContainerOne.topAnchor),
            titleLabelOne.leadingAnchor.constraint(equalTo: textContainerTwo.leadingAnchor, constant: 20),
            
            textFieldOne.topAnchor.constraint(equalTo: titleLabelOne.bottomAnchor, constant: screenHeight * 0.008),
            textFieldOne.leadingAnchor.constraint(equalTo: textContainerOne.leadingAnchor),
            textFieldOne.trailingAnchor.constraint(equalTo: textContainerOne.trailingAnchor),
            textFieldOne.heightAnchor.constraint(equalToConstant: screenHeight * 0.053),
            
            // Label 2 and TextField 2
            titleLabelTwo.topAnchor.constraint(equalTo: textContainerTwo.topAnchor),
            titleLabelTwo.leadingAnchor.constraint(equalTo: textContainerTwo.leadingAnchor, constant: 20),
            textFieldTwo.trailingAnchor.constraint(equalTo: textContainerTwo.trailingAnchor),
            
            textFieldTwo.topAnchor.constraint(equalTo: titleLabelTwo.bottomAnchor, constant: screenHeight * 0.008),
            textFieldTwo.leadingAnchor.constraint(equalTo: textContainerTwo.leadingAnchor),
            textFieldTwo.heightAnchor.constraint(equalToConstant: screenHeight * 0.053),
            
            chooseIconLabel.topAnchor.constraint(equalTo: textFieldTwo.bottomAnchor, constant: screenHeight * 0.029),
            chooseIconLabel.leadingAnchor.constraint(equalTo: textContainerTwo.leadingAnchor, constant: 20),
        ])
    }
    
    private func configureHorizontalStackView() {
        let screenHeight = UIScreen.main.bounds.height
        mainStackView.addArrangedSubview(iconContainerView)
        iconContainerView.addSubview(iconStackView)
        configureTexts()
        
        iconStackView.addArrangedSubview(redButton)
        iconStackView.addArrangedSubview(purpleButton)
        iconStackView.addArrangedSubview(greenButton)
        iconStackView.addArrangedSubview(yellowButton)
        
        NSLayoutConstraint.activate([
            iconContainerView.heightAnchor.constraint(equalToConstant: screenHeight * 0.1),
            iconStackView.topAnchor.constraint(equalTo: iconContainerView.topAnchor),
            iconStackView.leadingAnchor.constraint(equalTo: iconContainerView.leadingAnchor, constant: 40),
            iconStackView.trailingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: -40)
        ])
    }
    
    // For icon buttons
    private func createIconButton(image: String, selectedOrNot: Bool) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.isSelected = selectedOrNot
        
        let image = UIImage(named: image)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        
        button.addAction(UIAction { [weak self, weak button] _ in
            self?.deselectButtons()
            button?.isSelected = true
            self?.wrapInBorder(button)
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func deselectButtons() {
        redButton.isSelected = false
        purpleButton.isSelected = false
        greenButton.isSelected = false
        yellowButton.isSelected = false
        
        wrapInBorder(redButton)
        wrapInBorder(purpleButton)
        wrapInBorder(greenButton)
        wrapInBorder(yellowButton)
    }
    
    private func wrapInBorder(_ button: UIButton?) {
        guard let button = button else { return }
        
        if button.isSelected {
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.systemGreen.cgColor
            icon = button.image(for: .normal)
        } else {
            button.layer.borderWidth = 0
        }
    }
    
    private func configureAddButton() {
        view.addSubview(addButton)
        let screenHeight = UIScreen.main.bounds.height
        addButton.layer.cornerRadius = screenHeight * 0.035
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(lessThanOrEqualTo: mainStackView.bottomAnchor, constant: screenHeight * 1),
            addButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: screenHeight * -0.1),
            addButton.widthAnchor.constraint(equalToConstant: screenHeight * 0.18),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: screenHeight * 0.07)
        ])
    }
    
    private func setupAddButton() {
        guard let title = textFieldOne.text else { return }
        guard let description = textFieldTwo.text else { return }
        
        let newWuwuni = WuwuniModel(image: icon, titleLabel: title, wuwuniLabel: description)
        delegate?.addCard(newCard: newWuwuni)
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func buttonAction() {
        addButton.addAction(UIAction { [weak self] _ in
            self?.setupAddButton()
            self?.goBack()
        }, for: .touchUpInside)
    }
}

#Preview {
    AddNewCardPageVC()
}
