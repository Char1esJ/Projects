//
//  MessageCell.swift
//  Project
//
//  Created by Luka Ushikishvili on 11/16/25.
//

import UIKit
import Core

class MessageCell: UITableViewCell {
    
    private let bubbleView = UIView()
    private let messageLabel = UILabel()
    private let senderLabel = UILabel()
    private let timeLabel = UILabel()
    private let profileImageView = UIImageView()
    
    private let reactionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private var leftConstraint: NSLayoutConstraint!
    private var rightConstraint: NSLayoutConstraint!
    private var reactionsLeadingConstraint: NSLayoutConstraint!
    private var reactionsTrailingConstraint: NSLayoutConstraint!
    private var reactionsTopConstraint: NSLayoutConstraint!
    private var reactionsBottomConstraint: NSLayoutConstraint!
    private var messageToBubbleTopConstraint: NSLayoutConstraint!
    private var senderHeightConstraint: NSLayoutConstraint!
    private var messageToSenderConstraint: NSLayoutConstraint!
    
    var onAddReaction: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupViews() {
        
        profileImageView.layer.cornerRadius = 18
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.isHidden = true
        
        contentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bubbleView)
        contentView.addSubview(reactionsStackView)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            profileImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 36),
            profileImageView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        
        messageLabel.numberOfLines = 0
        
        senderLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        senderLabel.textColor = UIColor(red: 81/255, green: 89/255, blue: 246/255, alpha: 1.0)
        
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .secondaryLabel
        
        bubbleView.addSubview(senderLabel)
        bubbleView.addSubview(messageLabel)
        bubbleView.addSubview(timeLabel)
        
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        senderLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        reactionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        leftConstraint = bubbleView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8)
        
        rightConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        reactionsTopConstraint = reactionsStackView.topAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 4)
        reactionsLeadingConstraint = reactionsStackView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor)
        reactionsTrailingConstraint = reactionsStackView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor)
        reactionsBottomConstraint = reactionsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        
        senderHeightConstraint = senderLabel.heightAnchor.constraint(equalToConstant: 0)
        senderHeightConstraint.priority = .required - 1
        messageToBubbleTopConstraint = messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8)
        messageToSenderConstraint = messageLabel.topAnchor.constraint(equalTo: senderLabel.bottomAnchor, constant: 4)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 280),

            senderLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
            senderLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
            senderLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),
            
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),
            
            messageToSenderConstraint,
            
            timeLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 4),
            
            timeLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 4),
            timeLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),
            timeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: bubbleView.leadingAnchor, constant: 12),
            timeLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8),
            reactionsTopConstraint
        ])
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.minimumPressDuration = 0.5
        contentView.addGestureRecognizer(longPress)
        contentView.isUserInteractionEnabled = true
    }
    
    
    
    func configure(_ message: Message, currentUID: String) {
        messageLabel.text = message.text
        timeLabel.text = message.createdAt.toChatTimeString()
        
        if message.uid == currentUID {
            senderLabel.isHidden = true
            bubbleView.backgroundColor = .systemBlue
            profileImageView.isHidden = true
            
            leftConstraint.isActive = false
            rightConstraint.isActive = true
            
            senderHeightConstraint.isActive = true
            messageToSenderConstraint.isActive = false
            messageToBubbleTopConstraint.isActive = true
            
        } else {

            senderLabel.isHidden = false
            senderLabel.text = message.author
            bubbleView.backgroundColor = .secondarySystemGroupedBackground
            profileImageView.isHidden = false
            profileImageView.image = UIImage(named: message.imageName) ?? UIImage(systemName: "person.crop.circle.fill")
            
            rightConstraint.isActive = false
            leftConstraint.isActive = true
            
            senderHeightConstraint.isActive = false
            messageToBubbleTopConstraint.isActive = false
            messageToSenderConstraint.isActive = true
        }
        reactionsLeadingConstraint.isActive = message.uid != currentUID
        reactionsTrailingConstraint.isActive = message.uid == currentUID
        
        displayReactions(message.reactions)
        reactionsBottomConstraint.isActive = !message.reactions.isEmpty
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        reactionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        senderHeightConstraint.isActive = false
        messageToBubbleTopConstraint.isActive = false
        messageToSenderConstraint.isActive = true
    }
    
    private func displayReactions(_ reactions: [String: [String]]) {
        reactionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let sortedReactions = reactions.sorted { $0.key < $1.key }
        
        for (emoji, users) in sortedReactions {
            let reactionView = createReactionView(emoji: emoji, count: users.count)
            reactionsStackView.addArrangedSubview(reactionView)
        }
        
        reactionsStackView.isHidden = reactions.isEmpty
    }
    
    private func createReactionView(emoji: String, count: Int) -> UIView {
        let container = UIView()
        container.backgroundColor = .systemGray6
        container.layer.cornerRadius = 12
        
        let label = UILabel()
        label.text = "\(emoji) \(count)"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -4)
        ])
        
        return container
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        
        presentReactionPicker()
    }
    
    private func presentReactionPicker() {
        guard let viewController = findViewController() else { return }
        
        let pickerView = ReactionPickerView()
        pickerView.onReactionSelected = { [weak self] emoji in
            self?.onAddReaction?(emoji)
        }
        
        viewController.view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        let bubbleFrame = bubbleView.convert(bubbleView.bounds, to: viewController.view)
        let pickerWidth: CGFloat = 244
        let screenWidth = viewController.view.bounds.width
        let padding: CGFloat = 16
        
        var centerX = bubbleFrame.midX
        let halfWidth = pickerWidth / 2
        
        if centerX + halfWidth > screenWidth - padding {
            centerX = screenWidth - halfWidth - padding
        }
        
        if centerX - halfWidth < padding {
            centerX = halfWidth + padding
        }
        
        NSLayoutConstraint.activate([
            pickerView.widthAnchor.constraint(equalToConstant: pickerWidth),
            pickerView.bottomAnchor.constraint(equalTo: viewController.view.topAnchor, constant: bubbleFrame.minY - 8),
            pickerView.centerXAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: centerX)
        ])
        
        pickerView.present()
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
