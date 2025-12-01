//
//  MainPageViewController.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/22/25.
//

import UIKit

class MainPageViewController: UIViewController {
    // MARK: - Properties
    
    let viewModel: MainViewModel
    
    let url = "https://restcountries.com/v3.1/region/europe"
    
    private let titleLabel = UILabel.make(text: "Countries", fontSize: 25, weight: .bold, color: .black)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.collectionView?.backgroundColor = .blue
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let width: CGFloat = 350
        let height: CGFloat = 50
        layout.itemSize = CGSize(width: width, height: height)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        loadData()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
        collectionView.register(CountriesCell.self, forCellWithReuseIdentifier: "CountriesCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadData() {
        viewModel.loadCountries { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension MainPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCountries
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountriesCell", for: indexPath) as? CountriesCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.country(at: indexPath.row))
        return cell
    }
}

extension MainPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let country = viewModel.country(at: indexPath.row)
        
        let detailsPageViewModel = DetailsPageViewModel(country: country)
        
        let detailsVC = DetailsPageViewController(viewModel: detailsPageViewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
