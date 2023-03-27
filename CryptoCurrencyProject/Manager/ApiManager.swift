//
//  ApiManager.swift
//  CryptoCurrencyProject
//
//  Created by Serhat Demir on 27.03.2023.
//

import Foundation

class ApiManager {
    
    func fetchService(completion: @escaping(Result<[CryptoCurrency], Error>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let cryptoCurrency = try JSONDecoder().decode([CryptoCurrency].self, from: data)
                completion(.success(cryptoCurrency))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
