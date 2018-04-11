//
//  StarredPromotionViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol StarredPromotionDelegate: class {
    func isHiddenBtnStar(isHidden: Bool)
}

class StarredPromotionViewController: BaseViewController, UIScrollViewDelegate {
    @IBOutlet weak var cvStarredPromotion: UICollectionView!
    @IBOutlet weak var vSearch: SearchView!
    @IBOutlet weak var vHeader: UIView!
    @IBOutlet weak var vShadow: UIView!
    @IBOutlet weak var heightViewScroll: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    static var merchantName: String?
    weak var delegateScroll: ScrollDelegate?
    
    var viewModel: StarredPromotionViewModelProtocol!
    let disposeBag = DisposeBag()

    var refreshControl: UIRefreshControl!
    
    weak var buttonHidden: StarredPromotionDelegate?
    
    var listStarredPromotion = [Promotion]() {
        didSet {
            self.cvStarredPromotion.reloadData()
        }
    }
    var listSearch = [Promotion]()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        vSearch.tfSearch.text = ""
        bindData()
        viewModel.getListStarredPromotion(order:"desc")
        hideKeyboard()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configColecttionView()
        setUpView()
        
        vSearch.tfSearch.returnKeyType = .search
        refreshControl = UIRefreshControl()
        
        self.scrollView.addSubview(refreshControl)
        scrollView.delegate = self
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
        
        viewModel.listStarredPromotion.asObservable().subscribe(onNext: { promotions in
            guard let _promotions = promotions else { return }
            self.listStarredPromotion = _promotions
            self.listSearch = _promotions
            self.cvStarredPromotion.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layoutIfNeeded()
        vHeader.backgroundColor = PRColor.backgroundColor
        vShadow.setShadow(color: PRColor.lineColor, opacity: 1, offSet: CGSize(width: 0, height: 0), radius: 5, scale: false)
        vShadow.backgroundColor = .clear
        vSearch.tfSearch.attributedPlaceholder = "Search voucher".toAttributedString(color: UIColor.black.withAlphaComponent(0.5), font: PRFont.regular15, isUnderLine: false)
    }
    
    func setUpView() {
        self.view.backgroundColor = PRColor.backgroundColor
        scrollView.alwaysBounceVertical = true
        
    }
    
    class func configureViewController() -> StarredPromotionViewController {
        let starredPromotionVC = StarredPromotionViewController.initControllerFromNib() as! StarredPromotionViewController
        var viewModel: StarredPromotionViewModel {
            return StarredPromotionViewModel()
        }
        starredPromotionVC.viewModel = viewModel
        return starredPromotionVC
    }

    func configColecttionView() {
        cvStarredPromotion.register(UINib(nibName: Cell.promotionHeader, bundle: nil), forCellWithReuseIdentifier: Cell.promotionHeader)
        cvStarredPromotion.register(UINib(nibName: Cell.promotionCell, bundle: nil), forCellWithReuseIdentifier: Cell.promotionCell )
        cvStarredPromotion.register(UINib(nibName: Cell.emptyPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.emptyPromotion)
        cvStarredPromotion.isScrollEnabled = false
        cvStarredPromotion.backgroundColor = PRColor.backgroundColor
        cvStarredPromotion.delegate = self
        cvStarredPromotion.dataSource = self
    }
    

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if targetContentOffset.pointee.y == 0 {
            buttonHidden?.isHiddenBtnStar(isHidden: false)
            delegateScroll?.isScroll(direction: false, name: "StarredPromotionViewController")
        } else {
            buttonHidden?.isHiddenBtnStar(isHidden: true)
            delegateScroll?.isScroll(direction: true, name: "StarredPromotionViewController")
        }
    }
}

extension StarredPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        heightViewScroll.constant = cvStarredPromotion.contentSize.height + 60
        switch indexPath.section {
        case 0:
            
            let cell = cvStarredPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionHeader,for: indexPath) as! PromotionHeaderCell
            if self.listStarredPromotion.count == 0 {
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
            if self.listStarredPromotion.count == 0 {
                let cell = cvStarredPromotion.dequeueReusableCell(withReuseIdentifier: Cell.emptyPromotion, for: indexPath) as! EmptyPromotionCell
                
                return cell
            } else {
                let cell = cvStarredPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionCell, for: indexPath) as! PromotionCell
                if indexPath.item == listStarredPromotion.count - 1 {
                    cell.vLine.isHidden = true
                }
                cell.promotion = listStarredPromotion[indexPath.item]
                return cell
            }
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            if self.listStarredPromotion.count == 0 {
                return 1
            } else {
                return self.listStarredPromotion.count
            }
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if self.listStarredPromotion.count == 0 {
                return CGSize(width: collectionView.frame.width - 14, height: 50)
            } else {
                return CGSize(width: (collectionView.frame.width - 14), height: 50)
            }
        } else {
            if self.listStarredPromotion.count == 0 {
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
        if self.listStarredPromotion.count == 0 {
            return
        } else {
            if indexPath.section == 1 {
                guard let idVoucher = listStarredPromotion[indexPath.item].id else { return }
                let detailVoucherVC = PromotionDetailViewController.configureViewController(idVoucher: idVoucher)
                detailVoucherVC.merchantName = listStarredPromotion[indexPath.item].merchant?.name
                self.push(controller: detailVoucherVC, animated: true)
                StarredPromotionViewController.merchantName = listStarredPromotion[indexPath.item].merchant?.name
            }
        }
    }
}
extension StarredPromotionViewController: PromotionSortDelegate {
    func sortTapped() {
        PopUpHelper.shared.showPopUpSort(message: "Sort by", actionLatest: {
            self.viewModel.isLatest.value = true
        }) {
            self.viewModel.isLatest.value = false
        }
    }
}
