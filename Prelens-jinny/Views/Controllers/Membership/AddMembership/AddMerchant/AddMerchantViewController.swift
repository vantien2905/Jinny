//
//  AddMerchantViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddMerchantViewController: BaseViewController {

    @IBOutlet weak var vSearch: SearchView!
    @IBOutlet weak var tbMerchant: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        configureTableView()
        bindData()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableTapped))
        self.tbMerchant.addGestureRecognizer(tap)
    }
   
    var viewModel = AddMerchantViewModel()
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        vSearch.tfSearch.becomeFirstResponder()
        showNavigation()
        darkStatus()
        setTitle(title: "ADD MEMBERSHIP", textColor: .black, backgroundColor: .white)
        self.navigationController?.navigationBar.setShadow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        vSearch.tfSearch.resignFirstResponder()
//        hideNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        setUpView()
    }
    
    func setUpView() {
        vSearch.tfSearch.returnKeyType = .search
        vSearch.backgroundColor = .clear
        vSearch.setShadow(color: PRColor.lineColor, opacity: 1,
                          offSet: CGSize(width: 0, height: 0),
                          radius: 5, scale: true)
        vSearch.tfSearch.attributedPlaceholder = "Search merchant".toAttributedString(color: UIColor.black.withAlphaComponent(0.5), font: PRFont.regular15, isUnderLine: false)
    }
    
    @objc func tableTapped(tap:UITapGestureRecognizer) {
        let location = tap.location(in: self.tbMerchant)
        let path = self.tbMerchant.indexPathForRow(at: location)
        if let indexPathForRow = path {
            self.tbMerchant.delegate?.tableView!(self.tbMerchant, didSelectRowAt: indexPathForRow)
        } else {
            vSearch.tfSearch.resignFirstResponder()
        }
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        setTitle(title: "ADD MEMBERSHIP", textColor: .black, backgroundColor: .white)
//        addBackButton()
         self.addButtonToNavigation(image: PRImage.imgBack, style: .left, action: #selector(btnBackRootTapped))
    }
    
    @objc func btnBackRootTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func configureTableView() {
        tbMerchant.register(UINib(nibName: Cell.addMerchantCell, bundle: nil),
                            forCellReuseIdentifier: Cell.addMerchantCell)
        tbMerchant.delegate = self
        tbMerchant.backgroundColor = PRColor.backgroundColor
    }
    
    func bindData() {
        vSearch.tfSearch.rx.text.asObservable().subscribe( onNext: {
            [weak self] (text) in
            self?.viewModel.searchTextChange.value = text
        }).disposed(by: disposeBag)
        viewModel.loadData()
        viewModel.listMerchant.asObservable().bind(to: tbMerchant.rx.items) {
            table, index, merchant in
            let cell = table.dequeueReusableCell(withIdentifier: Cell.addMerchantCell) as! AddMerchantCell
            cell.merchant = merchant
            if index == self.viewModel.listMerchant.value.count - 1 {
                cell.vBottom.isHidden = true
            } else {
                cell.vBottom.isHidden = false
            }
            return cell
        }.disposed(by: disposeBag)
        
        tbMerchant.rx.modelSelected(Merchant.self).subscribe(onNext: {
            [weak self](merchant) in
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
