//
//  InfoView.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/23/25.
//

import UIKit

class InfoView: UIView {
    // MARK: - Properties
    
    private let titleLabel = UILabel.make(text: "Basic Information:", fontSize: 16, weight: .bold, color: .black) // ViewMOdelhere
    
    private let nativeNameLabel = UILabel.make(text: "Native name:", fontSize: 14, weight: .light, color: .black, alignment: .left)
    
    private let nativeNameValue = UILabel.make(text: "საქართველო", fontSize: 14, weight: .light, color: .black, alignment: .left)
    
    private let spellingLabel = UILabel.make(text: "Spelling:", fontSize: 14, weight: .light, color: .black)
    
    private let spellingValue = UILabel.make(text: "Sakartvelo", fontSize: 14, weight: .light, color: .black)
    
    private let capitalLabel = UILabel.make(text: "Capital:", fontSize: 14, weight: .light, color: .black)
    
    private let capitalValue = UILabel.make(text: "Tbilisi", fontSize: 14, weight: .light, color: .black)
    
    private let currencyLabel = UILabel.make(text: "Currency:", fontSize: 14, weight: .light, color: .black)
    
    private let currencyValue = UILabel.make(text: "Lari, ₾", fontSize: 14, weight: .light, color: .black)
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var nameRowStackView = UIStackView.make(axis: .horizontal, distribution: .equalSpacing, alignment: .center)
    
    private var spellingRowStackView = UIStackView.make(axis: .horizontal, distribution: .equalSpacing, alignment: .center)
    
    private var capitalRowStackView = UIStackView.make(axis: .horizontal, distribution: .equalSpacing, alignment: .center)
    
    private var currencyRowStackView = UIStackView.make(axis: .horizontal, distribution: .equalSpacing, alignment: .center)
    
    private var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        return view
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(mainStackView)
        
        [titleLabel, nameRowStackView, spellingRowStackView, capitalRowStackView, currencyRowStackView, lineView].forEach { mainStackView.addArrangedSubview($0) }
        
        nameRowStackView.addArrangedSubview(nativeNameLabel)
        nameRowStackView.addArrangedSubview(nativeNameValue)
        spellingRowStackView.addArrangedSubview(spellingLabel)
        spellingRowStackView.addArrangedSubview(spellingValue)
        capitalRowStackView.addArrangedSubview(capitalLabel)
        capitalRowStackView.addArrangedSubview(capitalValue)
        currencyRowStackView.addArrangedSubview(currencyLabel)
        currencyRowStackView.addArrangedSubview(currencyValue)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func configure(native: String, speelling: String, capital: String, currency: String) {
        nativeNameValue.text = native
        spellingValue.text = speelling
        capitalValue.text = capital
        currencyValue.text = currency
    }
}
