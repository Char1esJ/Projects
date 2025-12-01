//
//  ChatViewController.swift
//  Project
//
//  Created by Luka Ushikishvili on 11/16/25.
//

import UIKit
import Core
import Combine

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel: ChatViewModel
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let headerBar = HeaderBarView()	
    private let tableView = UITableView()
    private let inputContainer = inputContainerView()

    private var inputBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground

        setupHeaderBar()
        setupInputBar()
        setupTableView()
        setupKeyboardNotifications()
        setupTapGesture()
        subscribeToMessagePublisher()
        subscribeToUserReady()
        
        if viewModel.currentUser != nil {
            fetchMessages()
        }
        
        headerBar.onSettingsButtonTapped = { [weak self] in
            self?.viewModel.settingsButtonTapped()
        }
        
        inputContainer.onSendMessage = { [weak self] text in
            guard let self = self, let currentUser = self.viewModel.currentUser else { return }
            
            let newMessage = Message(
                uid: currentUser.userUID,
                imageName: currentUser.profileImageName ?? "default_avatar",
                text: text,
                createdAt: Date(),
                author: currentUser.username
            )

            self.viewModel.databaseMessages.append(newMessage)
            let indexPath = IndexPath(row: self.viewModel.databaseMessages.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            
            Task {
                do {
                    try await DatabaseManager.shared.sendMessageToDatabase(newMessage)
                } catch {
                    print("Failed to send message: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func subscribeToUserReady() {
        viewModel.userReadyPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self = self else { return }
                self.fetchMessages()
            }
            .store(in: &viewModel.tokens)
    }
    
    private func fetchMessages() {
        Task {
            let msgs = try await DatabaseManager.shared.fetchAllMessages()
            self.viewModel.databaseMessages = msgs
            await MainActor.run {
                self.tableView.reloadData()
            }
            
        }
    }
    
    private func subscribeToMessagePublisher() {
        DatabaseManager.shared.updatedMessagesPublisher
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] messages in
                guard let self = self else { return }
                self.viewModel.databaseMessages = messages
                self.tableView.reloadData()
                
                if self.viewModel.databaseMessages.isEmpty { return }
                
                let indexPath = IndexPath(row: messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                
            }.store(in: &viewModel.tokens)
    }

    private func setupHeaderBar() {
        view.addSubview(headerBar)
        view.bringSubviewToFront(headerBar)
        headerBar.translatesAutoresizingMaskIntoConstraints = false
        
        let topPad = UIView()
        topPad.backgroundColor = .systemGroupedBackground
        view.addSubview(topPad)
        topPad.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            headerBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerBar.heightAnchor.constraint(equalToConstant: 110),
            
            topPad.topAnchor.constraint(equalTo: view.topAnchor),
            topPad.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topPad.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topPad.bottomAnchor.constraint(equalTo: headerBar.topAnchor)
        ])
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear

        tableView.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor)
        ])
    }

    private func setupInputBar() {
        view.addSubview(inputContainer)
        inputContainer.translatesAutoresizingMaskIntoConstraints = false

        inputBottomConstraint = inputContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBottomConstraint,
            inputContainer.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        let height = keyboardFrame.height - view.safeAreaInsets.bottom
        inputBottomConstraint.constant = -height

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }

        if !viewModel.databaseMessages.isEmpty {
            let indexPath = IndexPath(row: viewModel.databaseMessages.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        inputBottomConstraint.constant = 0

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputBottomConstraint.constant = 0
        view.layoutIfNeeded()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.databaseMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        let message = viewModel.databaseMessages[indexPath.row]
        cell.configure(message, currentUID: viewModel.currentUser?.userUID ?? "")

        cell.onAddReaction = { [weak self] emoji in
            guard let self = self, let documentId = message.documentId else { return }
            self.viewModel.toggleReaction(to: documentId, emoji: emoji)
            
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        return cell
    }
}

extension ChatViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location = touch.location(in: view)
        
        if inputContainer.frame.contains(location) {
            return false
        }
        
        return true
    }
}
