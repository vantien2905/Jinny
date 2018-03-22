//
//  MembershipDetailVC.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class MembershipDetailViewController: BaseViewController {

    @IBOutlet weak var tbMembershipDetail: UITableView!

    @IBAction func btnLogoTapped() {
        let vcMerchantDetail = MerchantDetailViewController.configureViewController(idMerchant: 1)
        self.push(controller: vcMerchantDetail, animated: true)
    }

    let disposeBag = DisposeBag()

     var isStarTapped = false
    var viewModel: MembershipDetailViewModelProtocol!

    var membershipDetail = Member() {
        didSet {
            tbMembershipDetail.reloadData()
            membershipDetail.hasBookmark ? addStarButtonOn() : addStarButtonOff()
            isStarTapped = membershipDetail.hasBookmark
            if let _merchant = membershipDetail.merchant, let _name = _merchant.name {
                setTitle(title: _name, textColor: UIColor.black, backgroundColor: .white)
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        configureTableView()
        setNavigation()
        self.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        darkStatus()
    }

    func configureTableView() {
        tbMembershipDetail.register(UINib(nibName: Cell.membershipDetail, bundle: nil), forCellReuseIdentifier: Cell.membershipDetail)
        tbMembershipDetail.register(UINib(nibName: Cell.headerMemBershipDetail, bundle: nil), forCellReuseIdentifier: Cell.headerMemBershipDetail)
        tbMembershipDetail.register(UINib(nibName: Cell.footerMembershipDetail, bundle: nil), forCellReuseIdentifier: Cell.footerMembershipDetail)
        tbMembershipDetail.backgroundColor = PRColor.backgroundColor
        tbMembershipDetail.delegate = self
        tbMembershipDetail.dataSource = self

    }

    class func configureViewController(idMembership: Int) -> UIViewController {
        let vc = MembershipDetailViewController.initControllerFromNib() as! MembershipDetailViewController
        var viewModel: MembershipDetailViewModelProtocol {
            return MembershipDetailViewModel(idMember: idMembership)
        }
        vc.viewModel = viewModel
        return vc
    }

    func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        addBackButton()
    }

    func bindData() {
        viewModel.successRemove.asObservable().subscribe(onNext: { [weak self](isSuccess) in
            if isSuccess == true {
                self?.pop()
            }
        }).disposed(by: disposeBag)
        
        viewModel.membership.asObservable().subscribe(onNext: {[weak self] (member) in
            if let _member = member {
                self?.membershipDetail = _member
            }

        }).disposed(by: disposeBag)
    }

}

extension MembershipDetailViewController: BaseViewControllerDelegate {
    func starBookmarkTapped() {
        isStarTapped = !isStarTapped
        viewModel.isBookmark.value = true
        isStarTapped ? addStarButtonOn() : addStarButtonOff()
    }
}

extension MembershipDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.headerMemBershipDetail, for: indexPath) as! HeaderMembershipDetailCell
            let url = membershipDetail.merchant?.logo?.url?.thumb
            cell.setData(urlLogo: url, code: membershipDetail.code)
            //hhh
            cell.vContent.setShadow()
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.membershipDetail, for: indexPath) as! MembershipDetailCell
            if let _vouchers = membershipDetail.vouchers {
                if _vouchers.count > indexPath.item {
                    if let _image = _vouchers[indexPath.item].image, let _urlImage = _image.url, let _urlThumb = _urlImage.thumb {
                        cell.setData(urlImage: _urlThumb)
                    }
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.footerMembershipDetail, for: indexPath) as! FooterMembershipDetailCell
            cell.delegate = self
            return cell
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if let vouchers = membershipDetail.vouchers {
                return vouchers.count
            }
            return 0
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 270
        case 1:
            return 163
        default:
            return 50
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            
            let viewHeader = UIView()
            let lbTitle = UILabel()
            viewHeader.addSubview(lbTitle)
            lbTitle.text = "Related promotions"
            lbTitle.font = PRFont.semiBold15
            lbTitle.leftAnchor.constraint(equalTo: viewHeader.leftAnchor, constant: 23).isActive = true
            lbTitle.centerYToSuperview()
            viewHeader.backgroundColor = PRColor.backgroundColor
            return viewHeader
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 47.5
        } else if section == 2 {
            return 25
        } else {
            return 0
        }
    }
}

extension MembershipDetailViewController: FooterMembershipDetailCellDelegate {
    func isRemoveMembership() {
        self.viewModel.isRemoveMembership.value = true
    }
}
