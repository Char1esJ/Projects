//
//  MainViewModel.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/22/25.
//

import Foundation

class MainViewModel {
    private(set) var countries: [Country] = []
    
    private let networkManager: NetworkManager
    
    let countryURL = "https://restcountries.com/v3.1/region/europe"
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadCountries(completion: @escaping () -> ()) {
        networkManager.getData(url: countryURL) { [weak self] (result: Result<[Country], Error>) in
            switch result {
            case .success(let data):
                self?.countries = data
                
                DispatchQueue.main.async{
                    completion()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
                DispatchQueue.main.async{
                    completion()
                }
            }
        }
    }
    
    var numberOfCountries: Int {
        countries.count
    }
    
    func country(at index: Int) -> Country {
        countries[index]
    }
}
