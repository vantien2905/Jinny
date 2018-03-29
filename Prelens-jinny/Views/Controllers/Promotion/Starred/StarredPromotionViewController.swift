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

class StarredPromotionViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var cvStarredPromotion: UICollectionView!
    @IBOutlet weak var btnAddVoucher: UIButton!
    @IBOutlet weak var vSearch: SearchView!
    @IBOutlet weak var vHeader: UIView!
    @IBOutlet weak var vShadow: UIView!
    @IBOutlet weak var heightViewScroll: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    var viewModel: StarredPromotionViewModelProtocol!
    let disposeBag = DisposeBag()
    static var merchantName: String?
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
        viewModel.getListStarredPromotion()
        hideKeyboard()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        vSearch.tfSearch.returnKeyType = .search
        setUpView()
        configColecttionView()
    }
    
    @objc func bindData() {
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
    
    func setUpView() {
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        vHeader.backgroundColor = PRColor.backgroundColor
        vShadow.setShadow(color: PRColor.lineColor, opacity: 1, offSet: CGSize(width: 0, height: 0), radius: 5, scale: false)
        vShadow.backgroundColor = .clear
        vSearch.tfSearch.attributedPlaceholder = "Search voucher".toAttributedString(color: UIColor.black.withAlphaComponent(0.5), font: PRFont.regular15, isUnderLine: false)
    }
    
    class func configureViewController() -> UIViewController {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        self.view.layoutIfNeeded()
        //        print(actualPosition)
        if actualPosition.y > 0 {
            btnAddVoucher.isHidden = true
        } else if actualPosition.y < 0 {
            btnAddVoucher.isHidden = false
        }
    }
}

extension StarredPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        heightViewScroll.constant = cvStarredPromotion.contentSize.height + 60
        switch indexPath.section {
        case 0:
            
            let cell = cvStarredPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionHeader,
                                                          for: indexPath) as! PromotionHeaderCell
            
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
                return CGSize(width: collectionView.frame.width - 44, height: 50)
            } else {
                return CGSize(width: (collectionView.frame.width - 49), height: 50)
            }
        } else {
            if self.listStarredPromotion.count == 0 {
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
        if self.listStarredPromotion.count == 0 {
            return
        } else {
            if indexPath.section == 1 {
                guard let idVoucher = listStarredPromotion[indexPath.item].id else { return }
                let detailVoucherVC = PromotionDetailViewController.configureViewController(idVoucher: idVoucher)
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
