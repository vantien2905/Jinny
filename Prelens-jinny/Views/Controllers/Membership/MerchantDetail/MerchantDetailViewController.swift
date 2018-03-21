//
//  MerchantDetailViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift

class MerchantDetailViewController: BaseViewController {
    
    @IBOutlet weak var tbMerchantDetail: UITableView!
    @IBOutlet weak var imgMerchant: UIImageView!
    
    let disposeBag = DisposeBag()
    
    var merchantDetail = [MerchantDetail]() {
        didSet {
            tbMerchantDetail.reloadData()
        }
    }
    var viewModel: MerchantDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setUpNavigation()
    }
    
    func configureTableView() {
        tbMerchantDetail.register(UINib(nibName: Cell.merchantDetail, bundle: nil), forCellReuseIdentifier: Cell.merchantDetail)
        tbMerchantDetail.register(UINib(nibName: Cell.merchantDetailHeaderCell, bundle: nil), forHeaderFooterViewReuseIdentifier: "headerCell")
        
        tbMerchantDetail.delegate = self
        tbMerchantDetail.dataSource = self
    }
    
    class func configureViewController(idMerchant: Int) -> UIViewController {
        let vcMerchantDetail = MerchantDetailViewController.initControllerFromNib() as! MerchantDetailViewController
        var viewModel: MerchantDetailViewModelProtocol {
            return MerchantDetailViewModel(idMer: idMerchant)
        }
        vcMerchantDetail.viewModel = viewModel
        return vcMerchantDetail
    }
    
    func setUpNavigation() {
        self.setTitle(title: "StarBucks", textColor: .black, backgroundColor: .white)
        addBackButton()
    }
    
    func bindData() {
        viewModel.merchantDetail.asObservable().subscribe(onNext: { [weak self] merchants in
            self?.merchantDetail = merchants
        }).disposed(by: disposeBag)
        
    }
}

extension MerchantDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.merchantDetail, for: indexPath) as! MerchantDetailCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tbMerchantDetail.dequeueReusableCell(withIdentifier: "headerCell") as! MerchantDetailHeaderCell
        return  headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
}
