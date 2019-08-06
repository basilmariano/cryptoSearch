//
//  SearchCoinViewController.swift
//  CryptoCoinSearch
//
//  Created by Panfilo Mariano Jr on 06/08/2019.
//  Copyright © 2019 Panfilo Mariano Jr. All rights reserved.
//

import UIKit

class SearchCoinViewController: UIViewController {

    @IBOutlet private weak var searchBorderView: BorderedView! {
        didSet {
            searchBorderView.borderColor = .fantasyGreen
            searchBorderView.dropShadow(color: .fantasyGreen, opacity: 1, offSet: CGSize(width: -2, height: 4), radius: 1, scale: true)
        }
    }
    
    @IBOutlet private weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
        }
    }
    
    @IBOutlet private weak var clearSearchButton: UIButton!  {
        didSet {
            clearSearchButton.isHidden = true
        }
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            //tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    let cellId = "CoinTableViewCell"
    
    fileprivate var coins = [Coin]()
    fileprivate var filteredCoins: [Coin] = [Coin]()
    
    fileprivate var isSearching: Bool  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Coins"
        
        getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBorderView.dropShadow(color: .fantasyGreen, opacity: 1, offSet: CGSize(width: -2, height: 2), radius: 1, scale: true)
    }
    
    // MARK: - IBActions
    @IBAction private func didTapClearSearchText() {
        isSearching = false
        searchTextField.text = ""
        filteredCoins.removeAll()
        tableView.reloadData()
    }
    
    @IBAction private func didTapFilter() {
        print("Filter")
        if let filterVc = storyboard?.instantiateViewController(withIdentifier: "FilterUIViewViewController") as? FilterUIViewViewController {
            filterVc.delegate = self
            present(filterVc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private Functions
    private func getData() {
        let btc = Coin("Bitcoin", symbol: "BTC", price: 11749.00, oneHrChange: -0.12, twentyFourHrChange: 9.88, sevenDayChange: 23.18, thumb: UIImage(named: "bitcoin"))
        let eth = Coin("Ethereum", symbol: "ETH", price: 231.09, oneHrChange: -0.60, twentyFourHrChange: 5.30, sevenDayChange: 10.44, thumb: UIImage(named: "ethereum"))
        let xrp = Coin("XRP", symbol: "XRP", price: 0.33, oneHrChange: 0.18, twentyFourHrChange: 1.97, sevenDayChange: 5.96, thumb: UIImage(named: "ripple"))
        coins = [btc, eth, xrp]
        
        tableView.reloadData()
    }

    private func searchCoin(_ text: String) {
        
        if text.isEmpty {
            tableView.reloadData()
            return
        }
        
        filteredCoins =  coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(text) || coin.symbol.lowercased().contains(text)
        }
        
        tableView.reloadData()
    }
    
    private func filterCoin(_ filerOption: FilterOption) {
        
        filteredCoins.removeAll()
        
        switch filerOption {
        case .oneHrChange:
            coins = coins.sorted(by: { (c1, c2) -> Bool in
                return c1.oneHrChange > c2.oneHrChange
            })
        case .twentyFourHrChange:
            coins = coins.sorted(by: { (c1, c2) -> Bool in
                return c1.twentyFourHrChange > c2.twentyFourHrChange
            })
        case .sevenDayChange:
            coins = coins.sorted(by: { (c1, c2) -> Bool in
                return c1.sevenDayChange > c2.sevenDayChange
            })
        case .currentPrice:
            coins = coins.sorted(by: { (c1, c2) -> Bool in
                return c1.price > c2.price
            })
        case .coinName:
            coins = coins.sorted(by: { (c1, c2) -> Bool in
                return c1.name < c2.name
            })
        }
        
        tableView.reloadData()
    }
}


// MARK: - UITableViewDataSource
extension SearchCoinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredCoins.count : coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = isSearching ? filteredCoins[indexPath.row] : coins[indexPath.row]
        
        if let coinCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CoinTableViewCell {
            coinCell.updateCell(coin)
            return coinCell
        } else {
            //No Op
            print("No Cell")
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITextFieldDelegate
extension SearchCoinViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let nsString = textField.text! as NSString
        let newText = nsString.replacingCharacters(in: range, with: string)
        print(newText)
        isSearching = !newText.isEmpty
        clearSearchButton.isHidden = newText.isEmpty
        searchCoin(newText)
        
        
        return true
    }
}

// MARK: - UITextFieldDelegate
extension SearchCoinViewController: FilterUIViewViewControllerDelegate {
    func filter(_ viewController: UIViewController, didSelectFilterOption option: FilterOption?) {
        guard let option = option else {
            return
        }
        filterCoin(option)
    }
}
