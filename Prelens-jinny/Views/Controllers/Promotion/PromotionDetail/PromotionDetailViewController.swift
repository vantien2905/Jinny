//
//  PromotionDetailViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift

class PromotionDetailViewController: BaseViewController {
    
    @IBOutlet weak var cvVoucherDetail: UICollectionView!
    @IBOutlet weak var btnRedeem: UIButton!
    
    let disposeBag = DisposeBag()
    var isStarTapped = false
    var viewModel: PromotionDetailViewModelProtocol!
    
//    var promotionDetailData: Promotion? {
//        didSet {
//            guard let data = promotionDetailData else { return }
//        //    data.isBookmarked ? addStarButtonOn() : addStarButtonOff()
//        }
//    }
    
    var promotionDetail:  PromotionDetail? {
        didSet {
            cvVoucherDetail.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setNavigation(name: "Voucher Name")
        bindData()
    }
    
    class func configureViewController(idVoucher: Int) -> UIViewController {
        let vcVoucherDetail = PromotionDetailViewController.initControllerFromNib() as! PromotionDetailViewController
        var viewModel: PromotionDetailViewModelProtocol {
            return PromotionDetailViewModel(id: idVoucher)
        }
        vcVoucherDetail.viewModel = viewModel
        return vcVoucherDetail
    }
    
    func setNavigation(name: String) {
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: name, textColor: .black, backgroundColor: .white)
        addBackButton()
        addStarButtonOff()
        self.delegate = self
    }
    
    func bindData() {
//        viewModel.voucherDetail.asObservable().subscribe(onNext: { [weak self] voucher in
//            guard let strongSelf = self else { return }
//            strongSelf.promotionDetail = voucher
//        }).disposed(by: disposeBag)
    }
    
    func setUpComponents() {
        cvVoucherDetail.delegate = self
        cvVoucherDetail.dataSource = self
        
        cvVoucherDetail.register(UINib(nibName: Cell.promotionDetailCell, bundle: nil),
                                 forCellWithReuseIdentifier: "promotionDetailCell")
        cvVoucherDetail.register(UINib(nibName: Cell.promotionDetailHeaderCell, bundle: nil),
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                 withReuseIdentifier: "headerCell")
        cvVoucherDetail.register(UINib(nibName: Cell.promotionDetailFooterCell, bundle: nil),
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                 withReuseIdentifier: "footerCell")
    }
    
}

extension PromotionDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfCells = promotionDetail?.image?.count else { return 0 }
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promotionDetailCell",
                                                      for: indexPath) as! PromotionDetailCell
        guard let data = promotionDetail else { return UICollectionViewCell()}
        cell.backgroundColor = .white
//        cell.setUpView(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let data = promotionDetail else { return UICollectionViewCell()}
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath) as! PromotionDetailHeaderCell

//            headerCell.setUpView(with: data)
            return headerCell
        case UICollectionElementKindSectionFooter:
            let footerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "footerCell",
                                                                             for: indexPath) as! PromotionDetailFooterCell
            //setup the delegate for button here
            return footerCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width - 40
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 23, left: 0, bottom: 23, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
//        guard let text = promotionDetailData?.merchant?.name else { return CGSize(width: 0, height: 0) }
//        let height = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 2*20,
//                                 font: UIFont(name: "SegoeUI-Semibold", size: 17)!)
        let size = UIScreen.main.bounds.width
//        return CGSize(width: size, height: 125 - (57 - height))
         return CGSize(width: size, height: 125 - (57))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let size = UIScreen.main.bounds.width - 40
        return CGSize(width: size, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PRPhotoDetail()
//        vc.photoData = promotionDetailData
//        push(controller: vc, animated: true)
    }
}

extension PromotionDetailViewController: BaseViewControllerDelegate {
    func starBookmarkTapped() {
        isStarTapped = !isStarTapped
   //     viewModel.isBookmark.value = true
        isStarTapped ? addStarButtonOn() : addStarButtonOff()
     //   viewModel.addBookmarkVoucher(idBookmark: (promotionDetailData?.id)!)
    }
}




