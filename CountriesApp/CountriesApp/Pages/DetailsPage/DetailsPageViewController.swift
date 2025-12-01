//
//  DetailsPageViewController.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/23/25.
//

import UIKit

class DetailsPageViewController: UIViewController {
    // MARK: - Properties
    
    let viewModel: DetailsPageViewModel
    
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let topView = TopView()
    private let aboutView = AboutView()
    private let infoView = InfoView()
    private let bottomView = BottomView()
    
    init(viewModel: DetailsPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        configure()
    }
    
    // MARK: - Methods
    private func setupView() {
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(containerStackView)
        
        [topView, aboutView, infoView, bottomView].forEach { containerStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            containerStackView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor)
        ])
    }
    
    private func configure() {
        aboutView.configure(description: viewModel.flagInfo)
        bottomView.configure(openStreetsMaps: viewModel.openStreetMapsURL, googleMaps: viewModel.googleMapsURL)
        infoView
            .configure(native: viewModel.native, speelling: viewModel.spelling, capital: viewModel.capital, currency: "\(viewModel.currencyName),\(viewModel.currencySymbol)")
        topView.configure(title: viewModel.name, image: viewModel.flagImage)
    }
}

