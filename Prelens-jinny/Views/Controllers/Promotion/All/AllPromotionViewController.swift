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
    
    func configColecttionView(){
        cvAllPromotion.register(UINib(nibName: Cell.searchMemberShip, bundle: nil), forCellWithReuseIdentifier: Cell.searchMemberShip)
        cvAllPromotion.backgroundColor = PRColor.backgroundColor
        cvAllPromotion.delegate = self
        cvAllPromotion.dataSource = self
    }
}
extension AllPromotionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.searchMemberShip, for: indexPath)
            
            return cell
        } else {
            let cell = cvAllPromotion.dequeueReusableCell(withReuseIdentifier: Cell.searchMemberShip, for: indexPath)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return 5
        }
//        else if section == 1 {
//            if self.listMember.startedMemberships.count == 0 {
//                return 1
//            } else {
//                return self.listMember.startedMemberships.count
//            }
//
//        } else {
//            if self.listMember.otherMemberships.count == 0 {
//                return 1
//            } else {
//                return self.listMember.otherMemberships.count
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width - 30, height: 80)
        } else {
            return CGSize(width: (collectionView.frame.width - 35)/2, height: (collectionView.frame.width - 35)/2)
        }
//        else if indexPath.section == 1 {
//            if self.listMember.startedMemberships.count == 0 {
//                return CGSize(width: collectionView.frame.width - 30, height: 20)
//            } else {
//                return CGSize(width: (collectionView.frame.width - 35)/2, height: (collectionView.frame.width - 35)/2)
//            }
//        } else {
//            if self.listMember.otherMemberships.count == 0 {
//                return CGSize(width: collectionView.frame.width - 30, height: 20)
//            } else {
//                return CGSize(width: (collectionView.frame.width - 35)/2, height: (collectionView.frame.width - 35)/2)
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.frame.width, height: 10)
        } else {
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        var reusableView : UICollectionReusableView? = nil
    
//        // Create header
//        if (kind == UICollectionElementKindSectionHeader) {
//            // Create Header
//            if indexPath.section == 1 {
//                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.starredheader, for: indexPath as IndexPath) as! StarredHeaderCell
//                reusableView = headerView
//            } else {
//                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.otherHeader, for: indexPath as IndexPath) as! OtherHeaderCell
//                if listMember.otherMemberships.count == 0 {
//                    headerView.vSort.isHidden = true
//                    headerView.lbOther.text = "Other memberships"
//                } else {
//                    headerView.vSort.isHidden = false
//                    headerView.lbOther.text = "Other"
//                }
//                reusableView = headerView
//            }
//
//        } else {
//            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: Cell.membershipFooter, for: indexPath as IndexPath) as! MembershipFooterCell
//            reusableView = footerView
//        }
//
//        return reusableView!
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.section == 1 {
//            if listMember.startedMemberships.count != 0 {
//                let vc = MembershipDetailVC.configureViewController(id: self.listMember.startedMemberships[indexPath.item].id)
//                self.push(controller: vc, animated: true)
//            }
//
//        } else {
//            if listMember.otherMemberships.count != 0 {
//                let vc = MembershipDetailVC.configureViewController(id: self.listMember.otherMemberships[indexPath.item].id)
//                self.push(controller: vc, animated: true)
//            }
//        }
        
    }
}

