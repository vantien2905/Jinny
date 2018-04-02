//
//  PromotionViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController {
    @IBOutlet weak var vContainMenu: UIView!
    @IBOutlet weak var cvMenuController: UICollectionView!
    @IBOutlet weak var btnAddVoucher: UIButton!

    let vMenu: MenuView = {
        let view = MenuView()
        return view
    }()
    
    var currentIndex = 0
    var controllers = [UIViewController]()
    
    let vcAllPromotion = AllPromotionViewController.configureViewController()
    let vcStarredPromotion = StarredPromotionViewController.configureViewController()
    let vcAchivedPromotion = AchivedPromotionViewController.configureViewController()
    let cellId = "CellId"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
        vcAllPromotion.buttonHidden = self
        vcStarredPromotion.buttonHidden = self
        vcAchivedPromotion.buttonHidden = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        
        let listItemMenu = [
            MenuItem(title: "All", isSelected: true),
            MenuItem(title: "Starred", isSelected: false),
            MenuItem(title: "Archived", isSelected: false)
        ]
        controllers = [ vcAllPromotion, vcStarredPromotion, vcAchivedPromotion ]
        
        self.vMenu.setUpMenuView(menuColorBackground: .clear, listItem: listItemMenu,
                                 textFont: UIFont(name: "SegoeUI-Semibold", size: 15.0)!)

    }

    private func setupView() {
        configMenuView()
    }
    
    private func configMenuView() {
        self.vContainMenu.addSubview(vMenu)
        vMenu.delegate = self
        vMenu.fillSuperview()
    }
    func configCollectionView() {
        cvMenuController.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cvMenuController.dataSource = self
        cvMenuController.delegate = self
        cvMenuController.isPagingEnabled = true
    }
    
    @IBAction func goToAddVoucher() {
        let scanQRVC = AddVoucherViewController.instantiateFromNib()
        push(controller: scanQRVC, animated: true)
    }
}

extension PromotionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvMenuController.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let controler = controllers[indexPath.item]
        addChildViewController(controler)
        controler.view.frame = cell.contentView.bounds
        cell.addSubview(controler.view)
        controler.view.fillSuperview()
        
        didMove(toParentViewController: controler)
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        currentIndex = Int(index)
        vMenu.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        vMenu.scrollToIndex(index: Int(index))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: cvMenuController.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension PromotionViewController: MenuBarDelegate, AllPromotionDelegate {
    func itemMenuSelected(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        cvMenuController.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    func isHiddenBtnAll(isHidden: Bool) {
        self.btnAddVoucher.isHidden = isHidden
    }
}

extension PromotionViewController: StarredPromotionDelegate {
    func isHiddenBtnStar(isHidden: Bool) {
        self.btnAddVoucher.isHidden = isHidden
    }
}
extension PromotionViewController: ArchivedPromotionDelegate {
    func isHidden(isHidden: Bool) {
        self.btnAddVoucher.isHidden = isHidden
    }
}


