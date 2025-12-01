//
//  ViewController.swift
//  Assignment-N17
//
//  Created by Charles Janjgava on 10/14/25.
//

import UIKit

class MainPageVC: UIViewController, AddCardDelegate {
    // MARK: Properties
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackgrroundColorImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let wuwuniCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize(width: screenWidth * 0.41293, height: screenHeight * 0.27)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let wuwunCardButton: UIButton = {
        let button = UIButton()
        let screenHeight = UIScreen.main.bounds.height
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "WuwunButtonColor")
        button.setTitle("Add new complaint card", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: screenHeight * 0.018, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var tsutsunebi = [
        WuwuniModel(image: UIImage(named: "RedIcon"), titleLabel: "Change the Task", wuwuniLabel: "Who even wants to build a calculator?"),
        WuwuniModel(image: UIImage(named: "PurpleIcon"), titleLabel: "I Want Feedback", wuwuniLabel: "Please give feedback on assignments soon!"),
        WuwuniModel(image: UIImage(named: "GreenIcon"), titleLabel: "I’m Sleepy", wuwuniLabel: "So much studying and work, I need sleep ASAP"),
        WuwuniModel(image: UIImage(named: "YellowIcon"), titleLabel: "Extend the Day", wuwuniLabel: "24 hours isn’t enough, make it 36!")
    ]
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Methods
    private func setupView() {
        configureBackgroundImage()
        configureCollectionView()
        configureWuwunCardButton()
    }
    
    private func configureBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.bounds
    }
    
    private func configureCollectionView() {
        view.addSubview(wuwuniCollectionView)
        wuwuniCollectionView.register(WuwuniCell.self, forCellWithReuseIdentifier: "WuwuniCell")
        wuwuniCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            wuwuniCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wuwuniCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            wuwuniCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            wuwuniCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func pushOnOtherScreen() {
        let addNewCardPage = AddNewCardPageVC()
        addNewCardPage.delegate = self
        self.navigationController?.pushViewController(addNewCardPage, animated: true)
    }
    
    private func configureWuwunCardButton() {
        view.addSubview(wuwunCardButton)
        let screenHeight = UIScreen.main.bounds.height
        wuwunCardButton.layer.cornerRadius = screenHeight * 0.035
        wuwunCardButton.addAction(UIAction { [weak self] _ in
            self?.pushOnOtherScreen()
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            wuwunCardButton.topAnchor.constraint(lessThanOrEqualTo: wuwuniCollectionView.bottomAnchor, constant: 135),
            wuwunCardButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -105),
            wuwunCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            wuwunCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            wuwunCardButton.heightAnchor.constraint(equalToConstant: screenHeight * 0.07)
        ])
    }
    
    func addCard(newCard: WuwuniModel) {
        tsutsunebi.append(newCard)
        wuwuniCollectionView.reloadData()
    }
}

extension MainPageVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tsutsunebi.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WuwuniCell", for: indexPath) as? WuwuniCell
        else {
            return UICollectionViewCell()
        }
        
        let tsutsuni = tsutsunebi[indexPath.row]
        
        cell.configureCell(with: tsutsuni)
        
        return cell
    }
}

#Preview {
    MainPageVC()
}
