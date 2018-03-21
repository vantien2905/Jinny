//
//  AddMerchantViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift

class AddMerchantViewController: BaseViewController {

    @IBOutlet weak var vSearch: SearchView!
    @IBOutlet weak var tbMerchant: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUpView()
        configureTableView()
        bindData()
        hideKeyboard()
       
    }
    
    var viewModel = AddMerchantViewModel()
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigation()
        darkStatus()
        setTitle(title: "ADD MEMBERSHIP", textColor: .black, backgroundColor: .white)
        self.navigationController?.navigationBar.setShadow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideNavigation()
    }

    func setUpView() {
        vSearch.setShadow(color: PRColor.lineColor, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 2.5, scale: true)
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        setTitle(title: "ADD MEMBERSHIP", textColor: .black, backgroundColor: .white)
        addBackButton()
    }
    
    func configureTableView() {
        tbMerchant.register(UINib(nibName: Cell.addMerchantCell, bundle: nil), forCellReuseIdentifier: Cell.addMerchantCell)
        tbMerchant.delegate = self
        tbMerchant.backgroundColor = PRColor.backgroundColor
    }
    
    func bindData() {
        viewModel.loadData()
        viewModel.listMerchant.asObservable().bind(to: tbMerchant.rx.items) { table, _, merchant in
            let cell = table.dequeueReusableCell(withIdentifier: Cell.addMerchantCell) as! AddMerchantCell
            cell.merchant = merchant
            return cell
        }.disposed(by: disposeBag)
        
        tbMerchant.rx.modelSelected(Merchant.self).subscribe(onNext: { [weak self](merchant) in
            guard let strongSelf = self else { return }
            
            let vcScancode = ScanCodeViewController.configureController(merchant: merchant)

            strongSelf.push(controller: vcScancode, animated: true)
        }).disposed(by: disposeBag)
    }
}

extension AddMerchantViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.5
    }
}
