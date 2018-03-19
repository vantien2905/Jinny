//
//  AchivedPromotionViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class AchivedPromotionViewController: UIViewController {
    @IBOutlet weak var cvAchivedPromotion: UICollectionView!

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
        cvAchivedPromotion.register(UINib(nibName: Cell.searchPromotion, bundle: nil), forCellWithReuseIdentifier: Cell.searchPromotion)
        cvAchivedPromotion.register(UINib(nibName: Cell.promotionHeader, bundle: nil), forCellWithReuseIdentifier: Cell.promotionHeader)
        cvAchivedPromotion.register(UINib(nibName: Cell.promotionCell, bundle: nil), forCellWithReuseIdentifier: Cell.promotionCell )

        cvAchivedPromotion.backgroundColor = PRColor.backgroundColor
        cvAchivedPromotion.delegate = self
        cvAchivedPromotion.dataSource = self
    }

}
extension AchivedPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let cell = cvAchivedPromotion.dequeueReusableCell(withReuseIdentifier: Cell.searchPromotion, for: indexPath)

            return cell
        } else if indexPath.section == 1 {
            let cell = cvAchivedPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionHeader, for: indexPath)

            return cell
        } else {
            let cell = cvAchivedPromotion.dequeueReusableCell(withReuseIdentifier: Cell.promotionCell, for: indexPath)
            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section  == 1 {
            return 1
        } else {
            return 5
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width - 30, height: 70 )
        } else if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width - 30, height: 40 )
        } else {
            return CGSize(width: (collectionView.frame.width - 30), height:
                (collectionView.frame.height / 2  ))
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
