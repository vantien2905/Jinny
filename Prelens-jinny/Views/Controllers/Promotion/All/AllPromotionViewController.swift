//
//  AllPromotionViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol AllPromotionDelegate: class {
    func isHiddenBtnAll(isHidden: Bool)
}

class AllPromotionViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var cvAllPromotion: UICollectionView!
    @IBOutlet weak var vSearch: SearchView!
    @IBOutlet weak var vHeader: UIView!
    @IBOutlet weak var vShadow: UIView!
    @IBOutlet weak var heightViewScroll: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    static var merchantName: String?
    weak var delegateScroll: ScrollDelegate?
    
    var viewModel: AllPromotionViewModelProtocol!
    let disposeBag = DisposeBag()
    var listSearch = [Promotion]()
    var refreshControl: UIRefreshControl!
    var listPromotion = [Promotion]() {
        didSet {
            self.cvAllPromotion.reloadData()
        }
    }
    
    weak var buttonHidden: AllPromotionDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        hideKeyboard()
        vSearch.tfSearch.text = ""
        viewModel.getListAllPromotion(order: "desc")
        
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        bindData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configColecttionView()
        
        refreshControl = UIRefreshControl()
        scrollView.addSubview(refreshControl)
        scrollView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layoutIfNeeded()
        vHeader.backgroundColor = PRColor.backgroundColor
        vShadow.setShadow(color: PRColor.lineColor, opacity: 1, offSet: CGSize(width: 0, height: 0), radius: 5, scale: false)
        vShadow.backgroundColor = .clear
        vSearch.tfSearch.attributedPlaceholder = "Search voucher".toAttributedString(color: UIColor.black.withAlphaComponent(0.5), font: PRFont.regular15, isUnderLine: false)
    }
    @objc func getListNotification() {
        viewModel.getListAllPromotion(order: "desc")
    }
    func setUpView() {
        vSearch.backgroundColor = .clear
        self.view.backgroundColor = PRColor.backgroundColor
        
        vSearch.tfSearch.returnKeyType = .search
        scrollView.alwaysBounceVertical = true
        scrollView.bounces  = true
    }
    
    class func configureViewController() -> AllPromotionViewController {
        let allPromotionVC = AllPromotionViewController.initControllerFromNib() as! AllPromotionViewController
        var viewModel: AllPromotionViewModel {
            return AllPromotionViewModel()
        }
        allPromotionVC.viewModel = viewModel
        return allPromotionVC
    }
    
    func updateBadgeTabbar(list: [Promotion]) {
        var number = 0
        if list.count != 0 {
            for item in list where item.isReaded == false {
                number += 1
            }
        }
    }
    
    @objc func bindData() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else {return}
                strongSelf.viewModel.refresh()
                strongSelf.vSearch.tfSearch.text = ""
                strongSelf.vSearch.tfSearch.resignFirstResponder()
                strongSelf.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
        
        vSearch.tfSearch.rx.text.asObservable().subscribe( onNext: {[weak self](text) in
            self?.viewModel.textSearch.value = text
        }).disposed(by: disposeBag)
        
        viewModel.listAllPromotion.asObservable().subscribe(onNext: {listPromotions in
            guard let _listPromotions = listPromotions else { return }
            self.listPromotion = _listPromotions
            self.listSearch    = _listPromotions
            self.cvAllPromotion.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func configColecttionView() {
        cvAllPromotion.register(UINib(nibName: Cell.otherHeader, bundle: nil), forCellWithReuseIdentifier: Cell.otherHeader)
        cvAllPromotion.register(UINib(nibName: Cell.promotionCell, bundle: nil), forCellWithReuseIdentifier: Cell.promotionCell )
        cvAllPromotion.register(UINib(nibName: Cell.emptyPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.emptyPromotion)
        cvAllPromotion.isScrollEnabled = false
        cvAllPromotion.backgroundColor = PRColor.backgroundColor
        cvAllPromotion.delegate = self
        cvAllPromotion.dataSource = self
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        self.view.layoutIfNeeded()
        if targetContentOffset.pointee.y == 0 && actualPosition.y > 1 {
            buttonHidden?.isHiddenBtnAll(isHidden: false)
            delegateScroll?.isScroll(direction: false, name: "AllPromotionViewController")
        } else if  targetContentOffset.pointee.y == 0 && actualPosition.y < -1 {
            buttonHidden?.isHiddenBtnAll(isHidden: false)
            delegateScroll?.isScroll(direction: true, name: "AllPromotionViewController")
        } else {
            buttonHidden?.isHiddenBtnAll(isHidden: true)
            delegateScroll?.isScroll(direction: true, name: "AllPromotionViewController")
        }
    }
}
extension AllPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            if self.listPromotion.count == 0 {
                return 1
            } else {
                return self.listPromotion.count
            }
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        heightViewScroll.constant = cvAllPromotion.contentSize.height + 60
        switch indexPath.section {
        case 0:
            
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.otherHeader,
                                                          for: indexPath) as! OtherHeaderCell
            cell.lbOther.text = "All vouchers"
            if self.listPromotion.count == 0 {
                cell.vSort.isHidden = true
            } else {
                cell.vSort.isHidden = false
                if self.viewModel.isLatest.value {
                    cell.lbLatest.text = "Latest"
                } else {
                    cell.lbLatest.text = "Earliest"
                }
                cell.delegate = self
            }
            return cell
        default:
            if self.listPromotion.count == 0 {
                let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.emptyPromotion, for: indexPath) as! EmptyPromotionCell
                return cell
            } else {
                let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionCell, for: indexPath) as! PromotionCell
                cell.promotion = listPromotion[indexPath.item]
                if indexPath.item == listPromotion.count - 1 {
                    cell.vLine.isHidden = true
                }
                return cell
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if self.listPromotion.count == 0 {
                return CGSize(width: collectionView.frame.width - 14, height: 50)
            } else {
                return CGSize(width: (collectionView.frame.width - 14), height: 50)
            }
        } else {
            if self.listPromotion.count == 0 {
                return CGSize(width: collectionView.frame.width - 14, height: 30)
            } else {
                return CGSize(width: (collectionView.frame.width - 14), height: 300)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.listPromotion.count == 0 {
            return
        } else {
            if indexPath.section == 1 {
                guard let idVoucher = listPromotion[indexPath.item].id else { return }
                let detailVoucherVC = PromotionDetailViewController.configureViewController(idVoucher: idVoucher)
                detailVoucherVC.merchantName = self.listPromotion[indexPath.item].merchant?.name
                self.push(controller: detailVoucherVC, animated: true)
                AllPromotionViewController.merchantName = listPromotion[indexPath.item].merchant?.name
            }
        }
    }
}

extension AllPromotionViewController: OtherHeaderCellDelegate {
    func sortTapped() {
        PopUpHelper.shared.showPopUpSort(message: "Sort by", actionLatest: {
            self.viewModel.isLatest.value = true
        }) {
            self.viewModel.isLatest.value = false
        }
    }
}
