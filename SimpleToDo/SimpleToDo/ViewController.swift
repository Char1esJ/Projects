//
//  ViewController.swift
//  Assignment-N16
//
//  Created by Charles Janjgava on 10/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    var completedTodos: [ToDo] = [
        ToDo(title: "Plan your project idea", viewColor: UIColor(red: 0.98, green: 0.80, blue: 0.73, alpha: 1.00), noteImage: UIImageView(image: .note), date: "14 Oct"),
        ToDo(title: "Create a new Xcode project", viewColor: UIColor(red: 0.84, green: 0.94, blue: 1.00, alpha: 1.00), noteImage: UIImageView(image: .note), date: "15 Oct"),
        ToDo(title: "Set up your app structure", viewColor: UIColor(red: 0.98, green: 0.85, blue: 1.00, alpha: 1.00), noteImage: UIImageView(image: .note), date: "15 Oct"),
    ]
    
    var notCompletedTodos: [ToDo] = [
        ToDo(title: "Design the UI", viewColor: UIColor(red: 0.98, green: 0.80, blue: 0.73, alpha: 1.00), noteImage: UIImageView(image: .note), date: "16 Oct"),
        ToDo(title: "Create models", viewColor: UIColor(red: 0.84, green: 0.94, blue: 1.00, alpha: 1.00), noteImage: UIImageView(image: .note), date: "17 Oct"),
        ToDo(title: "Connect UI with data", viewColor: UIColor(red: 0.98, green: 0.85, blue: 1.00, alpha: 1.00), noteImage: UIImageView(image: .note), date: "18 Oct"),
        ToDo(title: "Add basic functionality", viewColor: UIColor(red: 0.98, green: 0.85, blue: 1.00, alpha: 1.00), noteImage: UIImageView(image: .note), date: "19 Oct"),
        ToDo(title: "Test the app", viewColor: UIColor(red: 0.98, green: 0.85, blue: 1.00, alpha: 1.00), noteImage: UIImageView(image: .note), date: "19 Oct"),
        ToDo(title: "Refine and polish", viewColor: UIColor(red: 0.98, green: 0.85, blue: 1.00, alpha: 1.00), noteImage: UIImageView(image: .note), date: "20 Oct")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupView()
        allDoneButton.applyGradient(colors: [UIColor(red: 0.45, green: 0.67, blue: 1.00, alpha: 1.00), UIColor(red: 0.27, green: 0.75, blue: 0.76, alpha: 1.00)], cornerRadius: 10)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        allDoneButton.applyGradient(colors: [UIColor(red: 0.45, green: 0.67, blue: 1.00, alpha: 1.00), UIColor(red: 0.27, green: 0.75, blue: 0.76, alpha: 1.00)], cornerRadius:  10)
    }
    
    private func setupView() {
        setupMainStackView()
        setupTitleStackView()
        setupInfoView()
        setupProgressStackView()
        setupTasksLabel()
        setupTableView()
    }
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
    
    private var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 30
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupTitleStackView() {
        mainStackView.addArrangedSubview(titleStackView)
    }
    
    private var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupInfoView() {
        titleStackView.addArrangedSubview(infoView)
        setupTitleArea()
        setupAllDoneButton()
    }
    
    private lazy var activeTasksTitle: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.text = "You have \(notCompletedTodos.count) active Tasks"
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.026, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func updateCounts() {
        activeTasksTitle.text = "You have \(notCompletedTodos.count) active Tasks"
        partyNumber.text = "\(notCompletedTodos.count)"
        ToDoTitle.text = "\(completedTodos.count)/9 tasks done"
        progressBar.setProgress(Float(completedTodos.count) / 9, animated: true)
        progressPercentage.text = "\(completedTodos.count * 100 / 9)%"
        
        let percentage = completedTodos.count * 100 / 9
        
        switch percentage {
        case 0: progressBarTitle.text = "Not Started"
        case 11: progressBarTitle.text = "Get Moving!"
        case 22: progressBarTitle.text = "Keep Going"
        case 33: progressBarTitle.text = "Making Progress"
        case 44: progressBarTitle.text = "Halfway There"
        case 55: progressBarTitle.text = "Stay Focused"
        case 66: progressBarTitle.text = "Almost Done!"
        case 77: progressBarTitle.text = "So Close!"
        case 88: progressBarTitle.text = "Final Stretch!"
        case 100: progressBarTitle.text = "Mission Accomplished"
        default: progressBarTitle.text = "Haven’t even started?"
        }
    }
    
    private var appImage: UIImageView = {
        let imageView = UIImageView()
        let screenHeight = UIScreen.main.bounds.height
        imageView.image = UIImage(named: "shalva")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var partyNumber: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.text = "\(notCompletedTodos.count)"
        label.textAlignment = .center
        label.backgroundColor = .orange
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.012)
        label.layer.cornerRadius = (screenHeight * 0.02) / 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupTitleArea() {
        infoView.addSubview(activeTasksTitle)
        infoView.addSubview(appImage)
        infoView.addSubview(partyNumber)
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            activeTasksTitle.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            activeTasksTitle.topAnchor.constraint(equalTo: infoView.topAnchor),
            activeTasksTitle.trailingAnchor.constraint(lessThanOrEqualTo: appImage.leadingAnchor, constant: -12),
            
            appImage.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            appImage.centerYAnchor.constraint(equalTo: activeTasksTitle.bottomAnchor, constant: 5),
            appImage.widthAnchor.constraint(equalTo: appImage.heightAnchor),
            appImage.heightAnchor.constraint(equalToConstant: screenHeight * 0.065),
            infoView.bottomAnchor.constraint(equalTo: partyNumber.bottomAnchor),
            
            partyNumber.trailingAnchor.constraint(equalTo: appImage.centerXAnchor, constant: 22),
            partyNumber.topAnchor.constraint(equalTo: appImage.centerYAnchor, constant: 18.5),
            partyNumber.widthAnchor.constraint(equalTo: partyNumber.heightAnchor),
            partyNumber.widthAnchor.constraint(equalToConstant: screenHeight * 0.02)
        ])
    }
    
    private var isCompleted = false
        
    private lazy var allDoneButton: UIButton = {
        let button = UIButton()
        let screenHeight = UIScreen.main.bounds.height
        button.layer.cornerRadius = screenHeight * 0.012
        button.clipsToBounds = true
        button.setTitle("All done", for: .normal)
        button.addAction(UIAction { [weak self] _ in
            self?.buttonTap()
            self?.tableView.reloadData()
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func buttonTap() {
        if !isCompleted {
            completedTodos.append(contentsOf: notCompletedTodos)
            notCompletedTodos.removeAll()
            allDoneButton.setTitle("None Done", for: .normal)
            isCompleted = true
        } else {
            notCompletedTodos.append(contentsOf: completedTodos)
            completedTodos.removeAll()
            allDoneButton.setTitle("All Done", for: .normal)
            isCompleted = false
        }
        tableView.reloadData()
        updateCounts()
    }
    
    private func setupAllDoneButton() {
        titleStackView.addArrangedSubview(allDoneButton)
        allDoneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private var progressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupProgressStackView() {
        mainStackView.addArrangedSubview(progressStackView)
        setupProgressContentView()
    }
    
    private var progressTitleLabel: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.03)
        label.text = "Progress"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var progressContentView: UIView = {
        let view = UIView()
        let screenHeight = UIScreen.main.bounds.height
        view.layer.cornerRadius = screenHeight * 0.012
        view.backgroundColor = UIColor(named: "ProgressViewBackgroundColor")
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var tasksTimeSpanTitle: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.019, weight: .medium)
        label.text = "1 Year tasks"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ToDoTitle: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.017)
        label.text = "\(completedTodos.count)/9 tasks Completed"
        label.alpha = 0.7
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressBarTitle: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.015)
        label.text = "lot of work to do"
        label.alpha = 0.5
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.setProgress(Float(completedTodos.count) / 6.0, animated: true)
        progress.tintColor = UIColor(red: 0.45, green: 0.67, blue: 1.00, alpha: 1.00)
        progress.trackTintColor = UIColor(red: 0.45, green: 0.67, blue: 1.00, alpha: 0.26)
        progress.layer.shadowColor = UIColor.black.cgColor
        progress.layer.shadowOpacity = 1
        progress.layer.shadowOffset = CGSize(width: 1, height: 3)
        progress.layer.shadowRadius = 6
        progress.layer.cornerRadius = 10
        progress.layer.masksToBounds = false
        progress.clipsToBounds = true
        
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private lazy var progressPercentage: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.016)
        label.text = "\(completedTodos.count * 100 / 9)%"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupProgressContentView() {
        progressStackView.addArrangedSubview(progressTitleLabel)
        progressStackView.addArrangedSubview(progressContentView)
        progressContentView.addSubview(tasksTimeSpanTitle)
        progressContentView.addSubview(ToDoTitle)
        progressContentView.addSubview(progressBarTitle)
        progressContentView.addSubview(progressBar)
        progressContentView.addSubview(progressPercentage)
        
        NSLayoutConstraint.activate([
            tasksTimeSpanTitle.topAnchor.constraint(equalTo: progressContentView.topAnchor, constant: 10),
            tasksTimeSpanTitle.leadingAnchor.constraint(equalTo: progressContentView.leadingAnchor, constant: 16),
            
            ToDoTitle.topAnchor.constraint(equalTo: tasksTimeSpanTitle.bottomAnchor, constant: 5),
            ToDoTitle.leadingAnchor.constraint(equalTo: tasksTimeSpanTitle.leadingAnchor),
            
            progressBarTitle.topAnchor.constraint(equalTo: ToDoTitle.bottomAnchor, constant: 4),
            progressBarTitle.leadingAnchor.constraint(equalTo: ToDoTitle.leadingAnchor),
            
            progressBar.topAnchor.constraint(equalTo: progressBarTitle.bottomAnchor, constant: 3),
            progressBar.leadingAnchor.constraint(equalTo: progressBarTitle.leadingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: progressContentView.bottomAnchor, constant: -25),
            progressBar.heightAnchor.constraint(equalToConstant: 18),
            progressBar.trailingAnchor.constraint(equalTo: progressContentView.trailingAnchor, constant: -16),
            
            progressPercentage.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor, constant: -10),
            progressPercentage.topAnchor.constraint(equalTo: progressBar.topAnchor, constant: -20)
        ])
    }
    
    // ------------------------ Table View --------------------------
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = UIColor(named: "BackgroundColor")
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var tasksLabel: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.text = "Tasks:"
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.026)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupTasksLabel() {
        view.addSubview(tasksLabel)
        NSLayoutConstraint.activate([
            tasksLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 30),
            tasksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            tasksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: tasksLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
        
        tableView.sectionHeaderHeight = 0
        
        tableView.register(taskData.self, forCellReuseIdentifier: "taskData")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

#Preview {
    ViewController()
}
