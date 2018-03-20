//
//  PromotionDetailViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PromotionDetailViewController: BaseViewController {
    
    @IBOutlet weak var cvVoucherDetail: UICollectionView!
    @IBOutlet weak var btnRedeem: UIButton!
    
    var promotionDetailData: Promotion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation(name: "Voucher Name")
        setUpComponents()
    }
    
    func setNavigation(name: String) {
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: name, textColor: .black, backgroundColor: .white)
        addBackButton()
        addStarButtonOff()
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promotionDetailCell",
                                                      for: indexPath) as! PromotionDetailCell
        guard let data = promotionDetailData else { return UICollectionViewCell()}
        cell.backgroundColor = .white
        cell.setUpView(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let data = promotionDetailData else { return UICollectionViewCell()}
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath) as! PromotionDetailHeaderCell
            
            headerCell.setUpView(with: data)
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
        let size = UIScreen.main.bounds.width - 46
        return CGSize(width: size, height: 1.5*size)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 23, left: 0, bottom: 23, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = UIScreen.main.bounds.width
        return CGSize(width: size, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let size = UIScreen.main.bounds.width - 40
        return CGSize(width: size, height: 100)
    }
    
}
