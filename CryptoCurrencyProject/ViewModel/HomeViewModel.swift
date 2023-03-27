//
//  HomeViewModel.swift
//  CryptoCurrencyProject
//
//  Created by Serhat Demir on 27.03.2023.
//

import Foundation

protocol HomeViewModelDelegate:AnyObject {
    func didFetchServiceSuccess(cryptoCurrency : [CryptoCurrency])
    func didFetchServiceFail(messega: String)
}

class HomeViewModel {
    
    // MARK: Delegate
    weak var delegate:HomeViewModelDelegate?
    
    func fetchService() {
        ApiManager().fetchService { result in
            switch result {
            case.success(let crypto):
                self.delegate?.didFetchServiceSuccess(cryptoCurrency: crypto)
            case.failure(let error):
                self.delegate?.didFetchServiceFail(messega: error.localizedDescription)
            }
        }
    }
}
