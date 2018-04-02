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

class AllPromotionViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var cvAllPromotion: UICollectionView!
    @IBOutlet weak var vSearch: SearchView!
    @IBOutlet weak var vHeader: UIView!
    @IBOutlet weak var vShadow: UIView!
    @IBOutlet weak var heightViewScroll: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel: AllPromotionViewModelProtocol!
    let disposeBag = DisposeBag()
    var listSearch = [Promotion]()
    static var merchantName: String?
    var refreshControl: UIRefreshControl!
    var listPromotion = [Promotion]() {
        didSet {
            self.cvAllPromotion.reloadData()
            UIApplication.shared.cancelAllLocalNotifications()
            for item in listPromotion {
//                LocalNotification.dispatchlocalNotification(with: (item.merchant?.name)!, body: "Test", day: item.expiresAt!, dayBeforeExprise: Int(KeychainManager.shared.getString(key:KeychainItem.leftDayToRemind)!)!)
            }
        }
    }
    
    weak var buttonHidden: AllPromotionDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        vSearch.tfSearch.text = ""
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        bindData()
        viewModel.getListAllPromotion(order: "desc")
        hideKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configColecttionView()
        setUpView()
        refreshControl = UIRefreshControl()
        self.scrollView.addSubview(refreshControl)
        vSearch.backgroundColor = .clear
    }
    
    func setUpView() {
        vSearch.tfSearch.returnKeyType = .search
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        vHeader.backgroundColor = PRColor.backgroundColor
        vShadow.setShadow(color: PRColor.lineColor, opacity: 1, offSet: CGSize(width: 0, height: 0), radius: 5, scale: false)
        vShadow.backgroundColor = .clear
        vSearch.tfSearch.attributedPlaceholder = "Search voucher".toAttributedString(color: UIColor.black.withAlphaComponent(0.5), font: PRFont.regular15, isUnderLine: false)
    }
    
    class func configureViewController() -> AllPromotionViewController {
        let allPromotionVC = AllPromotionViewController.initControllerFromNib() as! AllPromotionViewController
        var viewModel: AllPromotionViewModel {
            return AllPromotionViewModel()
        }
        allPromotionVC.viewModel = viewModel
        return allPromotionVC
    }
    
    @objc func bindData() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.refresh()
                self?.refreshControl.endRefreshing()
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
        cvAllPromotion.register(UINib(nibName: Cell.promotionHeader, bundle: nil), forCellWithReuseIdentifier: Cell.promotionHeader)
        cvAllPromotion.register(UINib(nibName: Cell.promotionCell, bundle: nil), forCellWithReuseIdentifier: Cell.promotionCell )
        cvAllPromotion.register(UINib(nibName: Cell.emptyPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.emptyPromotion)
        cvAllPromotion.isScrollEnabled = false
        cvAllPromotion.backgroundColor = PRColor.backgroundColor
        cvAllPromotion.delegate = self
        cvAllPromotion.dataSource = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        self.view.layoutIfNeeded()
        if actualPosition.y > 0 {
            buttonHidden?.isHiddenBtnAll(isHidden: true)
        } else if actualPosition.y < 0 {
            buttonHidden?.isHiddenBtnAll(isHidden: false)
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
            
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionHeader,
                                                          for: indexPath) as! PromotionHeaderCell
            
            if self.listPromotion.count == 0 {
                cell.vSort.isHidden = true
            } else {
                cell.vSort.isHidden = false
                if self.viewModel.isLatest.value {
                    cell.lbSort.text = "Latest"
                } else {
                    cell.lbSort.text = "Earliest"
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
                return cell
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if self.listPromotion.count == 0 {
                return CGSize(width: collectionView.frame.width - 44, height: 50)
            } else {
                return CGSize(width: (collectionView.frame.width - 49), height: 50)
            }
        } else {
            if self.listPromotion.count == 0 {
                return CGSize(width: collectionView.frame.width - 44, height: 50)
            } else {
                return CGSize(width: (collectionView.frame.width - 49), height: 300)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
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
                self.push(controller: detailVoucherVC, animated: true)
                AllPromotionViewController.merchantName = listPromotion[indexPath.item].merchant?.name
            }
        }
    }
}

extension AllPromotionViewController: PromotionSortDelegate {
    func sortTapped() {
        PopUpHelper.shared.showPopUpSort(message: "Sort by", actionLatest: {
            self.viewModel.isLatest.value = true
        }) {
            self.viewModel.isLatest.value = false
        }
    }
}
