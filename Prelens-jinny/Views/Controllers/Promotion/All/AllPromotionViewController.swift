//
//  AllPromotionViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class AllPromotionViewController: UIViewController {

    @IBOutlet weak var cvAllPromotion: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configColecttionView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configColecttionView() {
        cvAllPromotion.register(UINib(nibName: Cell.searchPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.searchPromotion)
        cvAllPromotion.register(UINib(nibName: Cell.promotionHeader, bundle: nil), forCellWithReuseIdentifier: Cell.promotionHeader)
        cvAllPromotion.register(UINib(nibName: Cell.promotionCell, bundle: nil), forCellWithReuseIdentifier: Cell.promotionCell )

        cvAllPromotion.backgroundColor = PRColor.backgroundColor
        cvAllPromotion.delegate = self
        cvAllPromotion.dataSource = self
    }
}
extension AllPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.searchPromotion, for: indexPath)
        
            return cell
        case 1:
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionHeader, for: indexPath)
            
            return cell
        default:
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionCell, for: indexPath)
            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 5
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
            return CGSize(width: (collectionView.frame.width - 30), height:
                (collectionView.frame.height / 2))
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let vc = PromotionDetailViewController.initControllerFromNib()
            self.push(controller: vc, animated: true)
        }
    }
}
