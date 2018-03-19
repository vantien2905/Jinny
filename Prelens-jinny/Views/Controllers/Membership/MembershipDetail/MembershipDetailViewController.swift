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
        let vcMerchantDetail = MerchantDetailViewController.configureViewController()
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
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        configureTableView()
        setNavigation()
        self.delegate = self
    }

    func configureTableView() {
        tbMembershipDetail.register(UINib(nibName: Cell.membershipDetail, bundle: nil), forCellReuseIdentifier: Cell.membershipDetail)
        tbMembershipDetail.register(UINib(nibName: Cell.headerMemBershipDetail, bundle: nil), forCellReuseIdentifier: Cell.headerMemBershipDetail)
        tbMembershipDetail.register(UINib(nibName: Cell.footerMembershipDetail, bundle: nil), forCellReuseIdentifier: Cell.footerMembershipDetail)

        tbMembershipDetail.delegate = self
        tbMembershipDetail.dataSource = self

    }

    class func configureViewController(id: Int) -> UIViewController {
        let vc = MembershipDetailViewController.initControllerFromNib() as! MembershipDetailViewController
        var viewModel: MembershipDetailViewModelProtocol {
            return MembershipDetailViewModel(idMember: id)
        }
        vc.viewModel = viewModel
        return vc
    }

    func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        setTitle(title: "STARBUCKS", textColor: UIColor.black, backgroundColor: .white)
        addBackButton()
    }

    func bindData() {
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
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.membershipDetail, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.footerMembershipDetail, for: indexPath)
            return cell
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 5
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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Related promotions"
        } else {
            return ""
        }

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        } else {
            return 0
        }
    }
}
