//
//  Country.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/23/25.
//

import Foundation

struct Country: Decodable {
    let name: Name
    let altSpellings: [String]
    let capital: [String]?
    let currencies: [String: Currency]?
    let maps: Maps
    let flags: Flags
    
    struct Name: Decodable {
        let common: String
        let official: String
        let nativeName: [String: NativeName]?
        
        struct NativeName: Decodable {
            let official: String
            let common: String
        }
    }
    
    struct Currency: Decodable {
        let name: String
        let symbol: String
    }
    
    struct Maps: Decodable {
        let googleMaps: String
        let openStreetMaps: String
    }
    
    struct Flags: Decodable {
        let png: String
        let svg: String
        let alt: String?
    }
}
