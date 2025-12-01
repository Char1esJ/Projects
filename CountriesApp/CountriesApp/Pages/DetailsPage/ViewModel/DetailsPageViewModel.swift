//
//  DetailsPageViewModel.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/22/25.
//

import Foundation

class DetailsPageViewModel {
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var name: String {
        country.name.common
    }
    
    var native: String {
        country.name.nativeName?.values.first?.common ?? "Unknown"
    }
    
    var spelling: String {
        country.altSpellings.last ?? "Spelling Unknown"
    }
    
    var capital: String {
        country.capital?.last ?? "Capital Unknown"
    }
    
    var currencyName: String {
        country.currencies?.values.first?.name ?? "Currency Unknown"
    }
    
    var currencySymbol: String {
        country.currencies?.values.first?.symbol ?? "Currency Unknown"
    }
    
    var openStreetMapsURL: String {
        country.maps.openStreetMaps
    }
    
    var googleMapsURL: String {
        country.maps.googleMaps
    }
    
    var flagImage: String {
        country.flags.png
    }
    
    var flagInfo: String {
        country.flags.alt ?? "Flag Unknown"
    }
}
