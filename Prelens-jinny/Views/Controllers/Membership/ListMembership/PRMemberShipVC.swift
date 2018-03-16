//
//  PRMemberShipVC.swift
//  Prelens-jinny
//
//  Created by Lamp on 13/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift

class PRMemberShipVC: BaseViewController {
    
    @IBOutlet weak var cvMembership: UICollectionView!
    
    let viewModel = MembershipViewModel()
    let disposeBag = DisposeBag()
    
    var listMember = Membership() {
        didSet {
            self.cvMembership.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(title: "Jinny")
        confireCollectionView()
        cvMembership.showsHorizontalScrollIndicator = false
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
    }
    
    func bindData() {
        viewModel.outputs.listMembership.asObservable().subscribe(onNext: { member in
            if let _member = member {
                self.listMember = _member
            }
            
        }).disposed(by: disposeBag)
    }
    
    func confireCollectionView() {
        cvMembership.register(UINib(nibName: Cell.memberShip, bundle: nil), forCellWithReuseIdentifier: Cell.memberShip)
        cvMembership.register(UINib(nibName: Cell.searchMemberShip, bundle: nil), forCellWithReuseIdentifier: Cell.searchMemberShip)
        cvMembership.register(UINib(nibName: Cell.emptyMembership, bundle: nil), forCellWithReuseIdentifier: Cell.emptyMembership)
        cvMembership.register(UINib(nibName: Cell.starredheader, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.starredheader)
        cvMembership.register(UINib(nibName: Cell.otherHeader, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.otherHeader)
        cvMembership.register(UINib(nibName: Cell.membershipFooter, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: Cell.membershipFooter)
        
        
        cvMembership.backgroundColor = PRColor.backgroundColor
        cvMembership.delegate = self
        cvMembership.dataSource = self
        cvMembership.contentInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
       
    }
    
}

extension PRMemberShipVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = cvMembership.dequeueReusableCell(withReuseIdentifier: Cell.searchMemberShip, for: indexPath)
            
            return cell
        } else if indexPath.section == 1 {
            if self.listMember.startedMemberships.count == 0 {
                let cell = cvMembership.dequeueReusableCell(withReuseIdentifier: Cell.emptyMembership, for: indexPath) as! EmptyMembershipCell
                
                return cell
            } else {
                let cell = cvMembership.dequeueReusableCell(withReuseIdentifier: Cell.memberShip, for: indexPath) as! MembershipCell

                cell.membership = listMember.startedMemberships[indexPath.item]
                return cell
            }
            
        } else {
            if listMember.otherMemberships.count == 0 {
                let cell = cvMembership.dequeueReusableCell(withReuseIdentifier: Cell.emptyMembership, for: indexPath) as! EmptyMembershipCell
                
                return cell
            } else {
                let cell = cvMembership.dequeueReusableCell(withReuseIdentifier: Cell.memberShip, for: indexPath) as! MembershipCell
                cell.membership = listMember.otherMemberships[indexPath.item]
                cell.imgStar.isHidden = true
                
                return cell
            }
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if self.listMember.startedMemberships.count == 0 {
                return 1
            } else {
                return self.listMember.startedMemberships.count
            }
            
        } else {
            if self.listMember.otherMemberships.count == 0 {
                return 1
            } else {
                return self.listMember.otherMemberships.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width - 30, height: 50)
        } else if indexPath.section == 1 {
            if self.listMember.startedMemberships.count == 0 {
                return CGSize(width: collectionView.frame.width - 30, height: 30)
            } else {
                return CGSize(width: (collectionView.frame.width - 35)/2, height: (collectionView.frame.width - 35)/2)
            }
        } else {
            if self.listMember.otherMemberships.count == 0 {
                return CGSize(width: collectionView.frame.width - 30, height: 30)
            } else {
                return CGSize(width: (collectionView.frame.width - 35)/2, height: (collectionView.frame.width - 35)/2)
            }
        }
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

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView? = nil
        
        // Create header
        if (kind == UICollectionElementKindSectionHeader) {
            // Create Header
            if indexPath.section == 1 {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.starredheader, for: indexPath as IndexPath) as! StarredHeaderCell
                reusableView = headerView
            } else {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.otherHeader, for: indexPath as IndexPath) as! OtherHeaderCell
                if listMember.otherMemberships.count == 0 {
                    headerView.vSort.isHidden = true
                    headerView.lbOther.text = "Other memberships"
                } else {
                   headerView.vSort.isHidden = false
                    headerView.lbOther.text = "Other"
                }
                reusableView = headerView
            }
            
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: Cell.membershipFooter, for: indexPath as IndexPath) as! MembershipFooterCell
            reusableView = footerView
        }
        
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = MembershipDetailVC.configureViewController(id: self.listMember.startedMemberships[indexPath.item].id)
            self.push(controller: vc, animated: true)
        } else {
            let vc = MembershipDetailVC.configureViewController(id: self.listMember.otherMemberships[indexPath.item].id)
            self.push(controller: vc, animated: true)
        }
        
    }
}



