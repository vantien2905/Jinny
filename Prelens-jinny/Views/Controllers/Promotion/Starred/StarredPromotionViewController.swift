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

class StarredPromotionViewController: UIViewController {

    @IBOutlet weak var cvStarredPromotion: UICollectionView!
    var viewModel: PromotionViewModelProtocol!
    let disposeBag = DisposeBag()
    
    var listStarredPromotion = [Promotion]() {
        didSet {
//            filteredData = listPromotion
            self.cvStarredPromotion.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        
        bindData()
//        viewModel.getListStarredPromotion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configColecttionView()
    }
    
    @objc func bindData() {
        viewModel.listStarredPromotion.asObservable().subscribe(onNext: { promotions in
            guard let _promotions = promotions else { return }
            self.listStarredPromotion = _promotions
            self.cvStarredPromotion.reloadData()
        }).disposed(by: disposeBag)
    }
    
    class func configureViewController() -> UIViewController {
        let starredPromotionVC = StarredPromotionViewController.initControllerFromNib() as! StarredPromotionViewController
        var viewModel: PromotionViewModelProtocol {
            return PromotionViewModel()
        }
        starredPromotionVC.viewModel = viewModel
        return starredPromotionVC
    }

    func configColecttionView() {
        cvStarredPromotion.register(UINib(nibName: Cell.searchPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.searchPromotion)
        cvStarredPromotion.register(UINib(nibName: Cell.promotionHeader, bundle: nil), forCellWithReuseIdentifier: Cell.promotionHeader)
        cvStarredPromotion.register(UINib(nibName: Cell.promotionCell, bundle: nil), forCellWithReuseIdentifier: Cell.promotionCell )
        cvStarredPromotion.register(UINib(nibName: Cell.emptyPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.emptyPromotion)

        cvStarredPromotion.backgroundColor = PRColor.backgroundColor
        cvStarredPromotion.delegate = self
        cvStarredPromotion.dataSource = self
    }
}

extension StarredPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = cvStarredPromotion.dequeueReusableCell(withReuseIdentifier: Cell.searchPromotion, for: indexPath)
            
            return cell
        case 1:
            let cell = cvStarredPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionHeader, for: indexPath) as! PromotionHeaderCell
            if self.listStarredPromotion.count == 0 {
                cell.vFilter.isHidden = true
            }
            return cell
        default:
            if self.listStarredPromotion.count == 0 {
                let cell = cvStarredPromotion.dequeueReusableCell(withReuseIdentifier: Cell.emptyPromotion, for: indexPath) as! EmptyPromotionCell
                
                return cell
            } else {
                let cell = cvStarredPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionCell, for: indexPath)
                return cell
            }
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 2:
            if listStarredPromotion.count == 0 {
                return 1
            } else {
                return listStarredPromotion.count
            }
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width - 30, height: 70 )
        case 1:
            return CGSize(width: collectionView.frame.width - 30, height: 40 )
        default:
            if self.listStarredPromotion.count == 0 {
                return CGSize(width: collectionView.frame.width - 30, height: 30)
            } else {
                return CGSize(width: (collectionView.frame.width - 30), height: (collectionView.frame.height / 2  ))
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

    }
}
