//
//  AchivedPromotionViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ArchivedPromotionDelegate: class {
    func isHidden(isHidden: Bool)
}

class AchivedPromotionViewController: UIViewController {
    @IBOutlet weak var cvAchivedPromotion: UICollectionView!
    @IBOutlet weak var vSearch: SearchView!
    @IBOutlet weak var vHeader: UIView!
    @IBOutlet weak var vShadow: UIView!
    @IBOutlet weak var heightViewScroll: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    var viewModel: AchivedPromotionViewModelProtocol!
    var refreshControl: UIRefreshControl!
    let disposeBag = DisposeBag()
    var listSearch = [Promotion]()
    var listAchivedPromotion = [Promotion]() {
        didSet {
            self.cvAchivedPromotion.reloadData()
        }
    }
    
    weak var buttonHidden: ArchivedPromotionDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        vSearch.tfSearch.text = ""
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        bindData()
        viewModel.getListAchivedPromotion(order: "desc")
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
    
    class func configureViewController() -> AchivedPromotionViewController {
        let achivedPromotionVC = AchivedPromotionViewController.initControllerFromNib() as! AchivedPromotionViewController
        var viewModel: AchivedPromotionViewModel {
            return AchivedPromotionViewModel()
        }
        achivedPromotionVC.viewModel = viewModel
        return achivedPromotionVC
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
        vSearch.tfSearch.returnKeyType = .search
        scrollView.alwaysBounceVertical = true
        
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
        
        viewModel.listAchivedPromotion.asObservable().subscribe(onNext: {listPromotions in
            guard let _listAchivedPromotions = listPromotions else { return }
            self.listAchivedPromotion = _listAchivedPromotions
            self.listSearch    = _listAchivedPromotions
            self.cvAchivedPromotion.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func configColecttionView() {
        cvAchivedPromotion.register(UINib(nibName: Cell.otherHeader, bundle: nil), forCellWithReuseIdentifier: Cell.otherHeader)
        cvAchivedPromotion.register(UINib(nibName: Cell.promotionCell, bundle: nil), forCellWithReuseIdentifier: Cell.promotionCell )
        cvAchivedPromotion.register(UINib(nibName: Cell.emptyPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.emptyPromotion)
        cvAchivedPromotion.isScrollEnabled = false
        cvAchivedPromotion.backgroundColor = PRColor.backgroundColor
        cvAchivedPromotion.delegate = self
        cvAchivedPromotion.dataSource = self
    }
}
extension AchivedPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        heightViewScroll.constant = cvAchivedPromotion.contentSize.height + 60
        switch indexPath.section {
        case 0:
            
            let cell = cvAchivedPromotion.dequeueReusableCell(withReuseIdentifier: Cell.otherHeader,
                                                          for: indexPath) as! OtherHeaderCell
            cell.lbOther.text = "All vouchers"
            if self.listAchivedPromotion.count == 0 {
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
            if self.listAchivedPromotion.count == 0 {
                let cell = cvAchivedPromotion.dequeueReusableCell(withReuseIdentifier: Cell.emptyPromotion, for: indexPath) as! EmptyPromotionCell
                
                return cell
            } else {
                let cell = cvAchivedPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionCell, for: indexPath) as! PromotionCell
                if indexPath.item == listAchivedPromotion.count - 1 {
                    cell.vLine.isHidden = true
                }
                cell.promotion = listAchivedPromotion[indexPath.item]
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
            if self.listAchivedPromotion.count == 0 {
                return 1
            } else {
                return self.listAchivedPromotion.count
            }
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if self.listAchivedPromotion.count == 0 {
                return CGSize(width: collectionView.frame.width - 44, height: 50)
            } else {
                return CGSize(width: (collectionView.frame.width - 49), height: 50)
            }
        } else {
            if self.listAchivedPromotion.count == 0 {
                return CGSize(width: collectionView.frame.width - 44, height: 30)
            } else {
                return CGSize(width: (collectionView.frame.width - 49), height: 300)
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
        if self.listAchivedPromotion.count == 0 {
            return
        } else {
            if indexPath.section == 1 {
                guard let idVoucher = listAchivedPromotion[indexPath.item].id else { return }
                let detailVoucherVC = PromotionDetailViewController.configureViewController(idVoucher: idVoucher)
                self.push(controller: detailVoucherVC, animated: true)
                AllPromotionViewController.merchantName = listAchivedPromotion[indexPath.item].merchant?.name
            }
        }
    }
}
extension AchivedPromotionViewController: OtherHeaderCellDelegate {
    func sortTapped() {
        PopUpHelper.shared.showPopUpSort(message: "Sort by", actionLatest: {
            self.viewModel.isLatest.value = true
        }) {
            self.viewModel.isLatest.value = false
        }
    }
}
