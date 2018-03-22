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
    var urlThumb: String?
    var merchantName: String?
    
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
        bindData()
        
    }
    
    func configureTableView() {
        tbMerchantDetail.register(UINib(nibName: Cell.merchantDetail, bundle: nil), forCellReuseIdentifier: Cell.merchantDetail)
        tbMerchantDetail.register(UINib(nibName: Cell.merchantDetailHeaderCell, bundle: nil), forCellReuseIdentifier: "headerCell")
        
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
        self.setTitle(title: MembershipDetailViewController.merchantName!, textColor: .black, backgroundColor: .white)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return merchantDetail.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell",
                                                     for: indexPath) as! MerchantDetailHeaderCell
            cell.imvMerchantAvatar.sd_setImage(with: MembershipDetailViewController.urlThumb!,
                                               placeholder: nil, failedImage: nil)
            cell.lbAddress.isHidden = true
            cell.tvDescription.isHidden = true
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.merchantDetail,
                                                     for: indexPath) as! MerchantDetailCell
            cell.lbMerchantName.text = merchantDetail[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return 35
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}

