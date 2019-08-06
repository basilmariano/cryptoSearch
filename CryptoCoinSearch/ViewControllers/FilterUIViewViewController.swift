//
//  FilterUIViewViewController.swift
//  CryptoCoinSearch
//
//  Created by Panfilo Mariano Jr on 06/08/2019.
//  Copyright © 2019 Panfilo Mariano Jr. All rights reserved.
//

import UIKit

enum FilterOption: Int {
    case oneHrChange = 1
    case twentyFourHrChange = 2
    case sevenDayChange = 3
    case currentPrice = 4
    case coinName = 5
}

protocol FilterUIViewViewControllerDelegate: NSObjectProtocol {
    func filter(_ viewController: UIViewController, didSelectFilterOption option: FilterOption?)
}

class FilterUIViewViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var options = [FilterOption.oneHrChange, FilterOption.twentyFourHrChange, FilterOption.sevenDayChange, FilterOption.currentPrice, FilterOption.coinName]
    var selectedFilter: FilterOption?
    var delegate: FilterUIViewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - IBAction

    @IBAction private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }


}

// MARK: - UITableViewDataSource
extension FilterUIViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        var title = ""
        
        let option = options[indexPath.row]
        switch option {
        case .oneHrChange:
            title = "1H Change"
        case .twentyFourHrChange:
            title = "24H Change"
        case .sevenDayChange:
            title = "7D Change"
        case .currentPrice:
            title = "Current Price"
        case .coinName:
            title = "Coin Name"
        }
        
        let titleLabel = cell.contentView.viewWithTag(1) as! UILabel
        titleLabel.text = title
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FilterUIViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        selectedFilter = option
        delegate?.filter(self, didSelectFilterOption: selectedFilter)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
