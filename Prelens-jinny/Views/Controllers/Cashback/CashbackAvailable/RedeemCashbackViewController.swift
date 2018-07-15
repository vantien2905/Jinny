//
//  RedeemCashbackViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 4/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class RedeemCashbackViewController: BaseViewController {
    
    @IBOutlet weak var cvRedeemCashback: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        configureCollectionView()
    }
    
    func setUpNavigation() {
        setTitle(title: "REDEEM CASHBACK", textColor: .black, backgroundColor: .white)
        self.addBackButton()
    }
    
    func configureCollectionView() {
        cvRedeemCashback.register(UINib(nibName: Cell.bankCashbackCell, bundle: nil), forCellWithReuseIdentifier: Cell.bankCashbackCell)
        cvRedeemCashback.register(UINib(nibName: Cell.voucherCashbackCell, bundle: nil), forCellWithReuseIdentifier: Cell.voucherCashbackCell)
        cvRedeemCashback.delegate = self
        cvRedeemCashback.dataSource = self
    }

}

extension RedeemCashbackViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.bankCashbackCell, for: indexPath)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.voucherCashbackCell, for: indexPath)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return CGSize(width: (collectionView.frame.width - 15)/2, height: 230)
        }
    }
}
