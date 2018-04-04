//
//  KPageViewController.swift
//  NCS
//
//  Created by Kai Pham on 11/21/17.
//  Copyright © 2017 sg.vinova.nsc. All rights reserved.
//

import UIKit
import RxSwift

class KPageViewController: BaseViewController {
    
    let vContaintMenu: UIView = {
        let view = UIView()
        view.backgroundColor = .white//NCSColor.whiteColor
        
        return view
    }()
    
    let vMenu: KPageMenuView = {
        let view = KPageMenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let cvContentController: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        
        return cv
    }()
    var currentIndexVariable: Variable<Int> = Variable<Int>(0)
    
    let cellId = "CellId"
    var currentIndex = 0 {
        didSet {
            self.currentIndexVariable.value = currentIndex
        }
    }
    
    var lcHeightMenu: NSLayoutConstraint?
    var lcWidthMenu: NSLayoutConstraint?
    var centerXMenu: NSLayoutConstraint?
    
    var controllers: [UIViewController] = [] {
        didSet {
            cvContentController.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToController(index: currentIndex)
        
       
        
        centerXMenu?.constant = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configureCollection()
        vMenu.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(fontSettingChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func fontSettingChanged() {
        vMenu.cvMenu.reloadData()
    }
    
    func setUpView() {
        self.view.addSubview(vContaintMenu)
        self.vContaintMenu.addSubview(vMenu)
        self.view.addSubview(cvContentController)
        
        if #available(iOS 11, *) {
            //---
            vContaintMenu.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            lcHeightMenu = vContaintMenu.safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: 47.5)
            lcHeightMenu?.isActive = true
            vMenu.backgroundColor = .red
            vMenu.fillVerticalSuperview()
            lcWidthMenu = vMenu.widthAnchor.constraint(equalToConstant: Utils.getMinimumWidthHeight() - 30)
            lcWidthMenu?.isActive = true
//            vMenu.centerXToSuperview()
            centerXMenu = vMenu.centerXAnchor.constraint(equalTo: vContaintMenu.safeAreaLayoutGuide.centerXAnchor, constant: 0)
            centerXMenu?.isActive = true
            
            cvContentController.anchor(vContaintMenu.safeAreaLayoutGuide.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        } else {
            //---
            vContaintMenu.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            lcHeightMenu = vContaintMenu.heightAnchor.constraint(equalToConstant: 47.5)
            lcHeightMenu?.isActive = true
            
            vMenu.fillVerticalSuperview()
            lcWidthMenu = vMenu.widthAnchor.constraint(equalToConstant: Utils.getMinimumWidthHeight() - 30)
            lcWidthMenu?.isActive = true
//            vMenu.centerXToSuperview()
            centerXMenu = vMenu.centerXAnchor.constraint(equalTo: vContaintMenu.centerXAnchor, constant: 0)
            centerXMenu?.isActive = true
            
            cvContentController.anchor(vContaintMenu.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        }
    }
}

extension KPageViewController: KPageMenuViewDelegate {
    func setUpViewMenu(menuColorBackground: UIColor, menuFont: UIFont, menuColorNormal: UIColor, menuColorSelected: UIColor, menuColorHorizontal: UIColor, heightHorizontal: CGFloat, listItem: [KCategory], isFull: Bool = false, isHaveLineTop: Bool = false) {
        vMenu.backgroundColor = menuColorBackground
        vMenu.menuFont = menuFont
        vMenu.menuColorSelected = menuColorSelected
        vMenu.menuColorNormal = menuColorNormal
        vMenu.heightHorizontal = heightHorizontal
        vMenu.menuColorHorizontal = menuColorHorizontal
        vMenu.isFullView = isFull
        vMenu.vLineTop.isHidden = !isHaveLineTop
        
        vMenu.listItem = listItem
    }
    
    func reloadMenu(listItem: [AnyObject]) {
        vMenu.listItem = listItem
    }
    
//    func setLayoutMenu(leading: CGFloat, trailling: CGFloat, heightMenu: CGFloat = 47.5) {
//        lcTraillingMenu?.constant = 0 - trailling
//        lcLeadingMenu?.constant = leading
//        lcHeightMenu?.constant = heightMenu
//    }
    
    func itemMenuSelected(index: Int) {
        currentIndex = index
        let controller = controllers[index]
        controller.viewWillAppear(true)
        let indexPath = IndexPath(item: index, section: 0)
        cvContentController.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    func scrollToController(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        cvContentController.scrollToItem(at: indexPath, at: .left, animated: true)
        vMenu.scrollToIndex(index: index)
        let controller = controllers[index]
        controller.viewWillAppear(true)
    }
}

// MARK: handle Collection view
extension KPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func configureCollection() {
        cvContentController.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cvContentController.delegate = self
        cvContentController.dataSource = self
        
        if let flow = cvContentController.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let controler = controllers[indexPath.item]
        addChildViewController(controler)
        controler.view.frame = cell.bounds
        cell.addSubview(controler.view)
//        controler.view.fillSuperview()
       
        didMove(toParentViewController: controler)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let controler = controllers[indexPath.item]
        controler.view.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        vMenu.setHorizontal(index: currentIndex)
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int ( targetContentOffset.pointee.x / cvContentController.frame.width )
        currentIndex = index
        vMenu.scrollToIndex(index: index)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let controler = controllers[indexPath.item]
        if let _con = controler as? KPageViewController {
            _con.cvContentController.reloadData()
        } else {
            controler.viewWillAppear(true)
        }
    }
}

extension KPageViewController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.cvContentController.collectionViewLayout.invalidateLayout()
            self.vMenu.cvMenu.collectionViewLayout.invalidateLayout()
            if self.currentIndex == 0 {
                self.cvContentController.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.currentIndex, section: 0)
                self.cvContentController.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
        }) 
    }
    
}

//--- KPageViewControllerCell

class KPageViewControllerCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    func setUpView() {
        self.backgroundColor = .clear
    }
}
