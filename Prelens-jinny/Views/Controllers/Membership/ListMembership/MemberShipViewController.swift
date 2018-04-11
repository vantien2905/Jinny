//
//  PRMemberShipVC.swift
//  Prelens-jinny
//
//  Created by Lamp on 13/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ScrollDelegate: class {
    func isScroll(direction: Bool, name: String)
}

class MemberShipViewController: BaseViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var cvMembership: UICollectionView!
    @IBOutlet weak var btnAddMembership: UIButton!
    @IBOutlet weak var vSearch: SearchView!
    @IBOutlet weak var vHeader: UIView!
    @IBOutlet weak var heightViewScroll: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vShadow: UIView!
    
    let viewModel = MembershipViewModel()
    let disposeBag = DisposeBag()
    weak var delegateScroll: ScrollDelegate?
    
    var refreshControl: UIRefreshControl!
    
    var listMember = Membership() {
        didSet {
            UIView.transition(with: cvMembership,
                              duration: 0.35,
                              options: .transitionCrossDissolve,
                              animations: { self.cvMembership.reloadData() })
        }
    }
    
    let viewDrop: UIView = {
        let view = UIView()
        return view
    }()
    
    let lbTitle: UILabel = {
        let label = UILabel()
        label.text = "Latest"
        return label
    }()
    
    var listSearch = Membership()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        vSearch.tfSearch.text = ""
        
        lightStatus()
        
        btnAddMembership.isHidden = false
        viewModel.getListMembership()
        bindData()
    }
    
    override func viewDidLayoutSubviews() {
        vHeader.backgroundColor = PRColor.backgroundColor
        vShadow.setShadow(color: PRColor.lineColor, opacity: 1,
                          offSet: CGSize(width: 0, height: 0),
                          radius: 5, scale: false)
        vShadow.backgroundColor = .clear
        vSearch.tfSearch.attributedPlaceholder = "Search membership".toAttributedString(color: UIColor.black.withAlphaComponent(0.5), font: PRFont.regular15, isUnderLine: false)
    }
    
    @IBAction func btnAddMembershipTapped() {
        let vcAddMerchant = AddMerchantViewController.initControllerFromNib()
        self.push(controller: vcAddMerchant, animated: true)
    }
    
    func setUpView() {
        vSearch.tfSearch.returnKeyType = .search
        scrollView.alwaysBounceVertical = true
        
        setTitle(title: "Jinny")
        confireCollectionView()
        scrollView.bounces  = true
        scrollView.delegate = self
        
        refreshControl = UIRefreshControl()
        self.scrollView.addSubview(refreshControl)
        
        cvMembership.showsHorizontalScrollIndicator = false
        hideKeyboard()
        vSearch.backgroundColor = .clear
    }
    
    func bindData() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                
                guard let strongSelf = self else { return }
                strongSelf.viewModel.refresh()
                strongSelf.vSearch.tfSearch.text = ""
                strongSelf.vSearch.tfSearch.resignFirstResponder()
                strongSelf.refreshControl.endRefreshing()
                
            })
            .disposed(by: disposeBag)
        
        vSearch.tfSearch.rx.text.asObservable().subscribe( onNext: {[weak self](text) in
            self?.viewModel.inputs.textSearch.value = text
        }).disposed(by: disposeBag)
        
        viewModel.outputs.listMembership.asObservable().subscribe(onNext: { member in
            if let _member = member {
                self.listMember = _member
                self.listSearch = _member
                self.cvMembership.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    func confireCollectionView() {
        cvMembership.register(UINib(nibName: Cell.memberShip, bundle: nil), forCellWithReuseIdentifier: Cell.memberShip)
        cvMembership.register(UINib(nibName: Cell.emptyMembership, bundle: nil), forCellWithReuseIdentifier: Cell.emptyMembership)
        cvMembership.register(UINib(nibName: Cell.starredheader, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.starredheader)
        cvMembership.register(UINib(nibName: Cell.otherHeader, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.otherHeader)
        cvMembership.register(UINib(nibName: Cell.membershipFooter, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: Cell.membershipFooter)
        
        cvMembership.backgroundColor = PRColor.backgroundColor
        cvMembership.contentInset = UIEdgeInsets(top: 0, left: 7, bottom: 22, right: 7)
        
        cvMembership.isScrollEnabled = false
        cvMembership.delegate = self
        cvMembership.dataSource = self
    }
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
            self.view.layoutIfNeeded()
            if actualPosition.y > 100 {
                btnAddMembership.isHidden = false
                delegateScroll?.isScroll(direction: false, name: "MembershipViewController")
                self.lightStatus()
            } else if actualPosition.y < -100 {
                btnAddMembership.isHidden = true
                delegateScroll?.isScroll(direction: true, name: "MembershipViewController")
                self.darkStatus()
            }
        }
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if targetContentOffset.pointee.y == 0 {
//            btnAddMembership.isHidden = false
//            delegateScroll?.isScroll(direction: false, name: "MembershipViewController")
//            self.lightStatus()
//            
//        } else if actualPosition.y < -100 {
//            btnAddMembership.isHidden = true
//           delegateScroll?.isScroll(direction: true, name: "MembershipViewController")
//            self.darkStatus()
//        }
//    }
    
}

extension MemberShipViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        heightViewScroll.constant = cvMembership.contentSize.height + 90
        if indexPath.section == 0 {
            if self.listMember.startedMemberships.count == 0 {
                let cell = cvMembership.dequeueReusableCell(withReuseIdentifier: Cell.emptyMembership, for: indexPath) as! EmptyMembershipCell
                cell.lbContent.text = ConstantString.Membership.emptyStarMembership
                return cell
                
            } else {
                let cell = cvMembership.dequeueReusableCell(withReuseIdentifier: Cell.memberShip, for: indexPath) as! MembershipCell
                cell.membership = listMember.startedMemberships[indexPath.item]
                cell.imgStar.isHidden = false
                return cell
                
            }
            
        } else {
            if listMember.otherMemberships.count == 0 {
                let cell = cvMembership.dequeueReusableCell(withReuseIdentifier: Cell.emptyMembership, for: indexPath) as! EmptyMembershipCell
                cell.lbContent.text = ConstantString.Membership.emptyOtherMembership
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
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
            if self.listMember.startedMemberships.count == 0 {
                return CGSize(width: collectionView.frame.width - 14, height: 20)
                
            } else {
                return CGSize(width: (collectionView.frame.width - 21)/2, height: (collectionView.frame.width - 21)/2*133/178)
            }
            
        } else {
            if self.listMember.otherMemberships.count == 0 {
                return CGSize(width: collectionView.frame.width - 14, height: 20)
                
            } else {
                return CGSize(width: (collectionView.frame.width - 21)/2, height: (collectionView.frame.width - 21)/2*133/178)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 42.5)
        } else {
            return CGSize(width: collectionView.frame.width, height: 42.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 15)
        } else {
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            // Create Header
            if indexPath.section == 0 {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.starredheader, for: indexPath as IndexPath) as! StarredHeaderCell
                reusableView = headerView
                
            } else {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Cell.otherHeader, for: indexPath as IndexPath) as! OtherHeaderCell
                headerView.delegate = self
                if listMember.otherMemberships.count == 0 {
                    headerView.vSort.isHidden = true
                    headerView.lbOther.text = "Other memberships"
                    
                } else {
                    headerView.vSort.isHidden = false
                    headerView.lbOther.text = "Other"
                    if self.viewModel.inputs.islatest.value {
                        headerView.lbLatest.text = "Latest"
                    } else {
                        headerView.lbLatest.text = "Earliest"
                    }
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
        if indexPath.section == 0 {
            if listMember.startedMemberships.count != 0 {
                let vc = MembershipDetailViewController.configureViewController(idMembership: self.listMember.startedMemberships[indexPath.item].id)
                self.push(controller: vc, animated: true)
            }
        } else {
            if listMember.otherMemberships.count != 0 {
                let vc = MembershipDetailViewController.configureViewController(idMembership: self.listMember.otherMemberships[indexPath.item].id)
                self.push(controller: vc, animated: true)
            }
        }
    }
}

extension MemberShipViewController: OtherHeaderCellDelegate {
    func sortTapped() {
        PopUpHelper.shared.showPopUpSort(message: "Sort by", actionLatest: {
            self.viewModel.inputs.islatest.value = true
        }) {
            self.viewModel.inputs.islatest.value = false
        }
    }
}
