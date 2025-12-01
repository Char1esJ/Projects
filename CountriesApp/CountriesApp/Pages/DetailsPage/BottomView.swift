//
//  BottomView.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/23/25.
//

import UIKit

class BottomView: UIView {
    // MARK: - Properties
    
    private let titleLabel = UILabel.make(text: "Useful links:", fontSize: 16, weight: .bold, color: .black)
    
    private var openStreetMapsButton = UIButton.make(imageName: "OpenStreetMaps")
    
    private var googleMapsButton = UIButton.make(imageName: "GoogleMaps")
    
    private var openStreetMapsURL: String = "https://www.openstreetmap.org"
    private var googleMapsURL: String = "https://www.google.com/maps"
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupView()
        buttonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(openStreetMapsButton)
        addSubview(googleMapsButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            openStreetMapsButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            openStreetMapsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            openStreetMapsButton.heightAnchor.constraint(equalTo: openStreetMapsButton.widthAnchor),
            openStreetMapsButton.widthAnchor.constraint(equalToConstant: ScreenSize.width * 0.16),
            
            googleMapsButton.topAnchor.constraint(equalTo: openStreetMapsButton.topAnchor),
            googleMapsButton.leadingAnchor.constraint(equalTo: openStreetMapsButton.trailingAnchor, constant: 100),
            googleMapsButton.heightAnchor.constraint(equalTo: googleMapsButton.widthAnchor),
            googleMapsButton.widthAnchor.constraint(equalTo: openStreetMapsButton.widthAnchor),
            googleMapsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
    
    func buttonActions() {
        openStreetMapsButton.addAction(UIAction { [weak self] _ in
            self?.openStreetMaps()
        }, for: .touchUpInside)
        
        googleMapsButton.addAction(UIAction { [weak self] _ in
            self?.googleMaps()
        }, for: .touchUpInside)
    }
    
    private func openStreetMaps() {
        guard let url = URL(string: openStreetMapsURL ) else { return }
        UIApplication.shared.open(url)
    }
    
    private func googleMaps() {
        guard let url = URL(string: googleMapsURL) else { return }
        UIApplication.shared.open(url)
    }
    
    func configure(openStreetsMaps: String, googleMaps: String) {
        openStreetMapsURL = openStreetsMaps
        googleMapsURL = googleMaps
    }
}
