//
//  taskData.swift
//  Assignment-N16
//
//  Created by Charles Janjgava on 10/10/25.
//

import UIKit

class taskData: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("has not been implemented")
    }
    
    var cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(named: "CellBackgroundColor")
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var leftColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var noteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Note")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.alpha = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emptyCheckList: UIButton = {
        let button = UIButton()
        let checkImage = UIImage(named: "checkMark")
        button.setImage(checkImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCellView() {
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        contentView.layer.cornerRadius = 10
        contentView.addSubview(cellView)
        cellView.addSubview(leftColorView)
        contentView.addSubview(taskTitleLabel)
        contentView.addSubview(noteImage)
        contentView.addSubview(dateLabel)
        contentView.addSubview(emptyCheckList)
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            leftColorView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            leftColorView.widthAnchor.constraint(equalToConstant: 15),
            
            leftColorView.topAnchor.constraint(equalTo: cellView.topAnchor),
            leftColorView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            
            taskTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            taskTitleLabel.leadingAnchor.constraint(equalTo: leftColorView.leadingAnchor, constant: 50),
            
            noteImage.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 5),
            noteImage.leadingAnchor.constraint(equalTo: taskTitleLabel.leadingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: noteImage.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: noteImage.trailingAnchor, constant: 3),
            
            emptyCheckList.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            emptyCheckList.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}

#Preview {
    ViewController()
}
