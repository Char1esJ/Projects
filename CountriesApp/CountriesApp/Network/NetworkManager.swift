//
//  NetworkManager.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/23/25.
//

import UIKit

enum NetworkError: Error {
    case noDataAvailable
    case unableToProcessData
    case decodingError
    case wrongStatusCode
    
    var localizedDescription: String {
        switch self {
        case .noDataAvailable: return "No data available"
        case .decodingError: return "Decoding error"
        case .wrongStatusCode: return "Wrong status code"
        case .unableToProcessData: return "Unable to process data"
        }
    }
}

class NetworkManager {
    func getData<T: Decodable>(url: String, completion: @escaping(Result<T,Error>)->()) {
        let urlString = url
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("API Error: \(error.localizedDescription)")
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("No Response")
                return
            }
            
            guard (200...300).contains(response.statusCode) else {
                print("Wrong status code")
                completion(.failure(NetworkError.wrongStatusCode))
                return
            }
            
            guard let data else {
                print("No data")
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                print("No country")
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}
