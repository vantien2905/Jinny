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

class AllPromotionViewController: UIViewController {

    @IBOutlet weak var cvAllPromotion: UICollectionView!
    @IBOutlet weak var btnAddVoucher: UIButton!
    
    var refresher: UIRefreshControl?
    
    let viewModel = PromotionViewModel()
    let disposeBag = DisposeBag()
    
    var listPromotion = [Promotion]() {
        didSet {
            self.cvAllPromotion.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        
        bindData()
        viewModel.getListPromotion()
        //pullToRefesh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configColecttionView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pullToRefesh() {
        self.refresher = UIRefreshControl()
        self.cvAllPromotion.alwaysBounceVertical = true
        self.refresher?.tintColor = UIColor.black
        self.refresher?.addTarget(self, action: #selector(bindData), for: .valueChanged)
        self.cvAllPromotion!.addSubview(refresher!)
    }
    func stopRefresher() {
        self.refresher?.endRefreshing()
    }
    
    @objc func bindData() {
        viewModel.outputs.listPromotion.asObservable().subscribe(onNext: { promotions in
            //if let _promotion = promotions {
                self.listPromotion = promotions
                self.cvAllPromotion.reloadData()
                self.stopRefresher()
            //}
        }).disposed(by: disposeBag)
    }
    
    func configColecttionView() {
        cvAllPromotion.register(UINib(nibName: Cell.searchPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.searchPromotion)
        cvAllPromotion.register(UINib(nibName: Cell.promotionHeader, bundle: nil), forCellWithReuseIdentifier: Cell.promotionHeader)
        cvAllPromotion.register(UINib(nibName: Cell.promotionCell, bundle: nil), forCellWithReuseIdentifier: Cell.promotionCell )
        cvAllPromotion.register(UINib(nibName: Cell.emptyPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.emptyPromotion)
        
        cvAllPromotion.backgroundColor = PRColor.backgroundColor
        cvAllPromotion.delegate = self
        cvAllPromotion.dataSource = self
    }
    
    func goToAddVoucher() {
        
    }
    
}
extension AllPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 2:
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
        switch indexPath.section {
        case 0:
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.searchPromotion, for: indexPath)
            return cell
        case 1:
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionHeader,
                                                          for: indexPath) as! PromotionHeaderCell
            if self.listPromotion.count == 0 {
                cell.vFilter.isHidden = true
            } else {
                cell.vFilter.isHidden = false
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
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width - 30, height: 70 )
        case 1:
            return CGSize(width: collectionView.frame.width - 30, height: 40 )
        default:
            if self.listPromotion.count == 0 {
                return CGSize(width: collectionView.frame.width - 30, height: 30)
            } else {
                return CGSize(width: (collectionView.frame.width - 30), height: (collectionView.frame.height / 2))
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
            if indexPath.section == 2 {
                let vc = PromotionDetailViewController()
                vc.promotionDetailData = listPromotion[indexPath.item]
                self.push(controller: vc, animated: true)
            }
        }
    }
}
