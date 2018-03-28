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
    var viewModel: PromotionViewModelProtocol!
    let disposeBag = DisposeBag()
    var filteredData: [Promotion] = []
    var listPromotion = [Promotion]() {
        didSet {
            filteredData = listPromotion
            self.cvAllPromotion.reloadData()
        }
    }
    
    static var merchantName: String?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        bindData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configColecttionView()
        
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
    
    class func configureViewController() -> UIViewController {
        let allPromotionVC = AllPromotionViewController.initControllerFromNib() as! AllPromotionViewController
        var viewModel: PromotionViewModelProtocol {
            return PromotionViewModel()
        }
        allPromotionVC.viewModel = viewModel
        return allPromotionVC
    }
    
    @objc func bindData() {
        viewModel.listAllPromotion.asObservable().subscribe(onNext: {listPromotions in
            guard let _listPromotions = listPromotions else { return }
            self.listPromotion = _listPromotions
            self.cvAllPromotion.reloadData()
            self.stopRefresher()
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
    
    @IBAction func goToAddVoucher() {
        let scanQRVC = AddVoucherViewController.instantiateFromNib()
        push(controller: scanQRVC, animated: true)
    }
    
}
extension AllPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 2:
            if self.filteredData.count == 0 {
                return 1
            } else {
                return self.filteredData.count
            }
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.searchPromotion, for: indexPath) as! SearchPromotionCell
            cell.tfSearch.text = ""
            cell.delegate = self
            return cell
        case 1:
            
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionHeader,
                                                          for: indexPath) as! PromotionHeaderCell
            
            if self.filteredData.count == 0 {
                cell.vFilter.isHidden = true
            } else {
                cell.vFilter.isHidden = false
                cell.delegate = self
            }
            return cell
        default:
            if self.filteredData.count == 0 {
                let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.emptyPromotion, for: indexPath) as! EmptyPromotionCell
                
                return cell
            } else {
                let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionCell, for: indexPath) as! PromotionCell
                cell.promotion = filteredData[indexPath.item]
                print(filteredData[indexPath.item].createDate)
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
            if self.filteredData.count == 0 {
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
        
        if self.filteredData.count == 0 {
            return
        } else {
            if indexPath.section == 2 {
                let idVoucher = filteredData[indexPath.item].id
                let detailVoucherVC = PromotionDetailViewController.configureViewController(idVoucher: idVoucher)
                self.push(controller: detailVoucherVC, animated: true)
                AllPromotionViewController.merchantName = filteredData[indexPath.item].merchant?.name
            }
        }
    }
}
extension AllPromotionViewController: SearchPromotionCellDelegate {
    func searchTextChange(textSearch: String?) {
        guard let _textSearch = textSearch else {return}
        filteredData = _textSearch.isEmpty ? listPromotion : listPromotion.filter{($0.merchant?.name?.lowercased().containsIgnoringCase(_textSearch))!}
        let indexHeader = IndexSet(integer: 1)
        let indexCollectionView = IndexSet(integer: 2)
        self.cvAllPromotion.reloadSections(indexCollectionView)
        self.cvAllPromotion.reloadSections(indexHeader)
    }
}
extension AllPromotionViewController: PromotionSortDelegate {
    func sortTapped() {
       print("sort button tapped")
    }
}
