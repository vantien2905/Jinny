//
//  RedeemVoucherViewController.swift
//  Prelens-jinny
//
//  Created by Lamp on 30/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class RedeemVoucherViewController: BaseViewController {
    
    @IBOutlet weak var cvRedeemVoucher: UICollectionView!
    
    var viewModel = RedeemVoucherViewModel()
    
    var promotionDetail: PromotionDetail? {
        didSet {
            //MARK: Setup the merchantName
            if let merchantName = promotionDetail?.merchantName {
                setNavigation(name: merchantName)
            } else {
                setNavigation(name: "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpComponents()
        
    }
    
    func setUpComponents() {
        darkStatus()
        cvRedeemVoucher.delegate = self
        cvRedeemVoucher.dataSource = self
        
        cvRedeemVoucher.register(UINib(nibName: Cell.promotionDetailHeaderCell, bundle: nil),
                                 forCellWithReuseIdentifier: "headerCell")
        cvRedeemVoucher.register(UINib(nibName: Cell.voucherRedeemFooterCell, bundle: nil),
                                 forCellWithReuseIdentifier: "redeemFooterCell")
        
        cvRedeemVoucher.backgroundColor = PRColor.backgroundColor
    }
    
    func setNavigation(name: String) {
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: name, textColor: .black, backgroundColor: .white)
        addBackButton()
    }
}

extension RedeemVoucherViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell",
                                                                for: indexPath) as! PromotionDetailHeaderCell
            if let data = promotionDetail {
                headerCell.setUpView(with: data)
            }
            
            return headerCell
        } else {
            let footerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "redeemFooterCell",
                                                                for: indexPath) as! RedeemVoucherFooterCell
            footerCell.btnRedeemedDelegate = self
            return footerCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let height = promotionDetail?.detailDescription?.height(withConstrainedWidth: UIScreen.main.bounds.width - 2*20,
                                                                    font: UIFont(name: "SegoeUI-Semibold", size: 17)!)
            let size = UIScreen.main.bounds.width
            guard let _height = height else { return CGSize(width: size, height: 125 - (57)) }
            return CGSize(width: size, height: 125 - (57 - _height))
        } else if indexPath.section == 1 {
            let size = UIScreen.main.bounds.width - 40
            return CGSize(width: size, height: 70)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 23, right: 0)
    }
}

extension RedeemVoucherViewController: RedeemVoucherFooterCellButtonDelegate {
    func btnRedeemedTapped() {
        PopUpHelper.shared.showPopUpYesNo(message: "Do you want to redeem this Voucher?", actionYes: {
            guard let idVoucher = self.promotionDetail?.id else { return }
            self.viewModel.redeemVoucher(idVoucher: idVoucher)
            PopUpHelper.shared.showPopUp(message: "Redeemed", height: 120, action: {
                self.pop()
            })
        }, actionNo: {})
    }
}
