//
//  AnswersViewController.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class AnswersViewController: UIViewController {
    // MARK: - Properties
    
    let questionView = QuestionView()
    let answersButtonView = AnswersButtonView()
    
    let answersViewModel: AnswersViewModel
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containerScroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private let answersList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWidth * 0.9, height: screenHeight * 0.08)
        
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
    
    // MARK: - Init
    
    init(answersViewModel: AnswersViewModel) {
        self.answersViewModel = answersViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupView()
        configure()
        registerCell()
        loadCount()
    }
    
    // MARK: - Methods
    
    private func loadCount() {
        let correctCount = UserDefaults.standard.integer(forKey: "correct")
        answersViewModel.correctAnswersCount = correctCount
        
        let wrongCount = UserDefaults.standard.integer(forKey: "wrong")
        answersViewModel.wrongAnswersCount = wrongCount
        
        updateButtonViewCount()
    }
    
    private func saveUserDefault() {
        UserDefaults.standard.set(answersViewModel.correctAnswersCount, forKey: "correct")
        UserDefaults.standard.set(answersViewModel.wrongAnswersCount, forKey: "wrong")
    }
    
    private func updateButtonViewCount() {
        answersButtonView.updateCounts(
            correct: answersViewModel.correctAnswersCount,
            wrong: answersViewModel.wrongAnswersCount
        )
    }
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.bounds
    }
    
    private func registerCell() {
        answersList.register(AnswersCell.self, forCellWithReuseIdentifier: "AnswersCell")
        
        answersList.dataSource = self
        answersList.delegate = self
    }
    
    private func setupView() {
        view.addSubview(containerScroll)
        containerScroll.addSubview(contentView)
        
        contentView.addSubview(questionView)
        contentView.addSubview(answersList)
        contentView.addSubview(answersButtonView)
        
        [questionView, answersButtonView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            containerScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: containerScroll.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: containerScroll.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: containerScroll.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerScroll.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            questionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            questionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            questionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            answersList.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 40),
            answersList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            answersList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            answersList.heightAnchor.constraint(equalToConstant: 310),
            
            answersButtonView.topAnchor.constraint(equalTo: answersList.bottomAnchor, constant: 60),
            answersButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            answersButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            answersButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -200),
            answersButtonView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configure() {
        questionView.configure(number: answersViewModel.number, question: answersViewModel.question)
    }
}

extension AnswersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        answersViewModel.answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswersCell", for: indexPath) as? AnswersCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(label: answersViewModel.answers[indexPath.row])
        return cell
    }
}

extension AnswersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnswersCell else { return }
        
        let selectedCell = answersViewModel.answers[indexPath.row]
        
        collectionView.isUserInteractionEnabled = false
                
        if selectedCell == answersViewModel.correctAnswer {
            cell.configureStyle(isCorrect: true)
            
            answersViewModel.correctAnswersCount += 1
        } else {
            cell.configureStyle(isCorrect: false)
            answersViewModel.wrongAnswersCount += 1
        }
        
        saveUserDefault()
        updateButtonViewCount()
    }
}
