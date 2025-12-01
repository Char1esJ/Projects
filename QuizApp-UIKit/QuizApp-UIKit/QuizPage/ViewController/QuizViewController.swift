//
//  QuizViewController.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class QuizViewController: UIViewController {
    // MARK: - Properties
    
    let topView = TopView()
    let quizViewModel = QuizViewModel()
    
    private let questionsList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 25
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWidth * 0.9, height: screenHeight * 0.06)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
        
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupView()
        registerCell()
        quizViewModel.fetchData()
        questionsList.reloadData()
    }
    
    // MARK: - Methods
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.bounds
    }
    
    private func registerCell() {
        questionsList.register(QuestionsCell.self, forCellWithReuseIdentifier: "QuestionsCell")
        
        questionsList.dataSource = self
        questionsList.delegate = self
    }
    
    private func setupView() {
        view.addSubview(topView)
        view.addSubview(questionsList)
        
        [topView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            questionsList.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            questionsList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionsList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionsList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension QuizViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        quizViewModel.quizContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionsCell", for: indexPath) as? QuestionsCell else {
            return UICollectionViewCell()
        }
        
        let quiz = quizViewModel.quizContent[indexPath.item]
        cell.configure(label: quiz.questionNumber)
        return cell
    }
}

extension QuizViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let question = quizViewModel.quizContent[indexPath.row]
        
        let answersViewModel = AnswersViewModel(result: question)
        
        let answersVC = AnswersViewController(answersViewModel: answersViewModel)
        navigationController?.pushViewController(answersVC, animated: true)
    }
}
