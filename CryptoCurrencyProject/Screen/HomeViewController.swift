//
//  ViewController.swift
//  CryptoCurrencyProject
//
//  Created by Serhat Demir on 27.03.2023.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private let viewModel = HomeViewModel()
    private var cryptoCurrency : [CryptoCurrency] = []
    private var animationView = LottieAnimationView(name: "loading")
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAnimationView()
        fetchService()
        addDelegates()
    }
}

// MARK: - Helpers
private extension HomeViewController {
    
    func fetchService() {
        animationView.play()
        animationView.isHidden = false
        viewModel.fetchService()
    }
    
    func addDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func setAnimationView() {
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.isHidden = true
        view.addSubview(animationView)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoCurrency.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeTableViewCell
        cell.currencyLabel.text = self.cryptoCurrency[indexPath.row].currency
        cell.priceLabel.text = self.cryptoCurrency[indexPath.row].price
        return cell
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func didFetchServiceSuccess(cryptoCurrency: [CryptoCurrency]) {
        self.cryptoCurrency = cryptoCurrency
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.animationView.stop()
            self.animationView.isHidden = true
        }
    }
    
    func didFetchServiceFail(messega: String) {
        self.makeAlert(titleInput: "Error", messageInput: messega)
        self.animationView.stop()
        self.animationView.isHidden = true
    }
}
