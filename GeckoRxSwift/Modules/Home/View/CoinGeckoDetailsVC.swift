//
//  ViewController.swift
//  GeckoRxSwift
//
//  Created by Mobile on 7/21/24.
//

import UIKit
import RxSwift
import RxCocoa

class CoinGeckoDetailsVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var tblDetails: UITableView!
    
    private let disposeBag = DisposeBag()
    private var viewModel = CoinViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "Coin Gecko"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        bindViewModel()
        viewModel.fetchCoins()
    }
    
    private func setupTableView() {
        tblDetails.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "CoinCell")
    }
    
    private func bindViewModel() {
        tblDetails.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.coins.bind(to: tblDetails.rx.items(cellIdentifier: "CoinCell", cellType: CoinCell.self)) { row, coin, cell in
            cell.lblName?.text = coin.name
            cell.lblSymbol.text = coin.symbol
            cell.lblValue.text = "$ \(coin.current_price)"
        }
        .disposed(by: disposeBag)
    }
}

extension CoinGeckoDetailsVC : UITableViewDelegate{}
    
