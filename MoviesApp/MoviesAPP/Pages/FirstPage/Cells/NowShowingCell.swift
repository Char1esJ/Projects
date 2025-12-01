//
//  NowShowingCell.swift
//  Assignment-N19
//
//  Created by Charles Janjgava on 10/20/25.
//

import UIKit

class NowShowingCell: UITableViewCell {
    private let nowShowingCV = NowShowingCV()
    var movieSelected: ((MovieModel) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white
        contentView.addSubview(nowShowingCV)
        nowShowingCV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nowShowingCV.topAnchor.constraint(equalTo: contentView.topAnchor),
            nowShowingCV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nowShowingCV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nowShowingCV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with viewModel: MoviesViewModel) {
        nowShowingCV.viewModel = viewModel
        nowShowingCV.movieSelected = { [weak self] movie in
            self?.movieSelected?(movie)
        }
    }
}
