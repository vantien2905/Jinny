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
    
    let disposeBag = DisposeBag()
    
    static var urlThumb: String?
    static var merchantName: String?
    
    var cellSize: [CGFloat]? = [CGFloat]()
    
    var isStarTapped = false
    var viewModel: MembershipDetailViewModelProtocol!
    
    var membershipDetail = Member() {
        didSet {
            getCellSize()
            guard let merchant = membershipDetail.merchant?.name else {return}
            setTitle(title: merchant, textColor: UIColor.black, backgroundColor: .white)
            guard let url = membershipDetail.merchant?.logo?.url?.thumb else { return }
            MembershipDetailViewController.urlThumb = url
            MembershipDetailViewController.merchantName = membershipDetail.merchant?.name
            
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
        ProgressLoadingHelper.shared.showIndicator()
    }
    override func viewWillAppear(_ animated: Bool) {
        darkStatus()
    }
    
    func getCellSize() {
        let data = self.membershipDetail
        var imgString = [String]()
        guard let _vouchers = data.vouchers else { return }
        
        for voucher in _vouchers {
            guard let _imgString = (voucher.image?.url?.original) else { return }
            imgString.append(_imgString)
        }
        
        for img in imgString {
            guard let url = URL(string: img) else { return }
            if let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil) {
                if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                    let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! CGFloat
                    let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! CGFloat
                    let imageWidth  = pixelWidth
                    let imageHeight = pixelHeight
                    let cellWidth   = UIScreen.main.bounds.width - 14
                    let cellHeight  = (cellWidth*imageHeight)/imageWidth
                    self.cellSize?.append(cellHeight)
                }
            }
        }
    }
    
    func configureTableView() {
        tbMembershipDetail.register(UINib(nibName: Cell.membershipDetail, bundle: nil), forCellReuseIdentifier: Cell.membershipDetail)
        tbMembershipDetail.register(UINib(nibName: Cell.headerMemBershipDetail, bundle: nil), forCellReuseIdentifier: Cell.headerMemBershipDetail)
        tbMembershipDetail.register(UINib(nibName: Cell.footerMembershipDetail, bundle: nil), forCellReuseIdentifier: Cell.footerMembershipDetail)
        tbMembershipDetail.estimatedRowHeight = 100
        tbMembershipDetail.rowHeight = UITableViewAutomaticDimension
        
        tbMembershipDetail.backgroundColor = PRColor.backgroundColor
        tbMembershipDetail.separatorStyle = .none
        tbMembershipDetail.delegate = self
        tbMembershipDetail.dataSource = self
        
    }
    
    class func configureViewController(idMembership: Int) -> MembershipDetailViewController {
        let vc = MembershipDetailViewController.initControllerFromNib() as! MembershipDetailViewController
        var viewModel: MembershipDetailViewModelProtocol {
            return MembershipDetailViewModel(idMember: idMembership)
        }
        vc.viewModel = viewModel
        return vc
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        setTitle(title: "", textColor: UIColor.black, backgroundColor: .white)
        self.addButtonToNavigation(image: PRImage.imgBack, style: .left, action: #selector(btnBackRootTapped))
    }
    
    @objc func btnBackRootTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func bindData() {
        viewModel.successRemove.asObservable().subscribe(onNext: { [weak self](isSuccess) in
            if isSuccess == true {
                self?.navigationController?.popToRootViewController(animated: true)
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
            let url = membershipDetail.merchant?.logo?.url?.original
            cell.setData(urlLogo: url, code: membershipDetail.code)
            cell.headerCellDelegate = self
            cell.vContent.setShadow()
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.membershipDetail, for: indexPath) as! MembershipDetailCell
            if let _voucher = membershipDetail.vouchers {
                _voucher[indexPath.item].merchant = membershipDetail.merchant
                cell.promotion = _voucher[indexPath.item]
            }
            cell.backgroundColor = .yellow
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.footerMembershipDetail, for: indexPath) as! FooterMembershipDetailCell
            cell.backgroundColor = PRColor.backgroundColor
            cell.vContent.backgroundColor = PRColor.backgroundColor
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
            return UITableViewAutomaticDimension
        case 1:
            guard let height = cellSize else { return 300 }
            return 50 + height[indexPath.row]
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let viewHeader = UIView()
            let lbTitle = UILabel()
            viewHeader.addSubview(lbTitle)
            lbTitle.text = "Related promotions"
            lbTitle.font = PRFont.semiBold15
            lbTitle.leftAnchor.constraint(equalTo: viewHeader.leftAnchor, constant: 6).isActive = true
            lbTitle.centerYToSuperview()
            viewHeader.backgroundColor = PRColor.backgroundColor
            return viewHeader
        } else {
            let viewHeder = UIView()
            viewHeder.backgroundColor = PRColor.backgroundColor
            return viewHeder
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 47.5
        } else if section == 2 {
            return 5
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let _vouchers = membershipDetail.vouchers else { return }
            let _voucher = _vouchers[indexPath.item]
            guard let id = _voucher.id else { return }
            let detailVoucherVC = PromotionDetailViewController.configureViewController(idVoucher: id)
            push(controller: detailVoucherVC, animated: true)
        }
    }
}

extension MembershipDetailViewController: FooterMembershipDetailCellDelegate {
    func isRemoveMembership() {
        self.viewModel.isRemoveMembership.value = true
    }
}

extension MembershipDetailViewController: HeaderMembershipDetailCellDelegate {
    func goToMerchantDetail() {
        guard let idMerchant = membershipDetail.merchant?.id else { return }
        
        let vcMerchantDetail = MerchantDetailViewController.configureViewController(idMerchant: idMerchant)
        self.push(controller: vcMerchantDetail, animated: true)
    }
}
