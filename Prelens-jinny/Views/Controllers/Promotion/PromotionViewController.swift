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
    let vMenu: MenuView = {
        let view = MenuView()
        return view
    }()

    var currentIndex = 0
    var controllers = [UIViewController]()

     let vcAllPromotion = AllPromotionViewController.initControllerFromNib() as! AllPromotionViewController
    let vcStarredPromotion = StarredPromotionViewController.initControllerFromNib() as! StarredPromotionViewController
    let vcAchivedPromotion = AchivedPromotionViewController.initControllerFromNib() as! AchivedPromotionViewController
    let cellId = "CellId"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()

        let listItemMenu = [
            MenuItem(title: "All", isSelected: true),
            MenuItem(title: "Stared", isSelected: false),
            MenuItem(title: "Archived", isSelected: false)
        ]
        controllers = [ vcAllPromotion, vcStarredPromotion, vcAchivedPromotion ]

        self.vMenu.setUpMenuView(menuColorBackground: .clear, listItem: listItemMenu, textFont: UIFont(name: "SegoeUI-Semibold", size: 15.0)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension PromotionViewController: MenuBarDelegate {
    func itemMenuSelected(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        cvMenuController.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
