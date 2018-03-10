//
//  PRLoginManagerVC.swift
//  Prelens-jinny
//
//  Created by vinova on 3/9/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PRLoginManagerVC: UIViewController {
    
    let vLogo:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let vContaintMenu: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    let lbAppName:UILabel = {
        let label = UILabel()
        label.text = "JINNY"
        label.font = UIFont(name: "Ostrich Sans", size: 23 )
        label.textColor = #colorLiteral(red: 0.8901960784, green: 0.07058823529, blue: 0.0431372549, alpha: 1)
        return label
    }()
    
    let vMenu: MenuView = {
        let view = MenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let cellId = "CellId"
    
    let cvContainMenu:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    var vInput:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    //var vcLogin: PRLoginManagerViewModel!
    
    let vcSignIn = PRSignInViewController.initControllerFromNib() as! PRSignInViewController
    let vcSignUp = PRSignUpViewController.initControllerFromNib() as! PRSignUpViewController
    
    var currentIndex = 0
    var controllers = [UIViewController]()
    var parentNavigationController  : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupCollectionView()
        setupView()
        vcSignIn.parentNavigationController = self.parentNavigationController
        
        vcSignUp.parentNavigationController = self.parentNavigationController
        let listItemMenu = [
            MenuItem(title: "SIGN UP", isSelected: true),
            MenuItem(title: "SIGN IN", isSelected: false)
        ]
        controllers = [ vcSignUp, vcSignIn ]
        vMenu.setUpMenuView(menuColorBackground: .clear, listItem: listItemMenu)
        //--
        vMenu.delegate = self
        //addControllerToViewAt(index: currentIndex)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //scrollToController(index: currentIndex)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView(){
        view.addSubview(vLogo)
        vLogo.addSubview(lbAppName)
        view.addSubview(vContaintMenu)
        view.addSubview(cvContainMenu)
        //view.addSubview(vInput)
        vContaintMenu.addSubview(vMenu)
        
        vLogo.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
        lbAppName.centerXToSuperview()
        lbAppName.centerYToSuperview()
        
        vContaintMenu.anchor(vLogo.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 60)
        vMenu.anchor(vContaintMenu.topAnchor, left: vContaintMenu.leftAnchor, bottom: vContaintMenu.bottomAnchor, right: vContaintMenu.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cvContainMenu.anchor(vContaintMenu.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        //vInput.anchor(vContaintMenu.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupCollectionView(){
        cvContainMenu.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cvContainMenu.dataSource = self
        cvContainMenu.delegate = self
        //cvContainMenu.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        //cvContainMenu.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        cvContainMenu.isPagingEnabled = true
    }
    
    func addControllerToViewAt(index: Int) {
        let controller = controllers[index]
        self.cvContainMenu.subviews.forEach { _view in
            _view.removeFromSuperview()
        }
        
        self.addChildViewController(controller)
        self.vInput.addSubview(controller.view)
        controller.view.fillSuperview()
        controller.didMove(toParentViewController: self)
    }
}
extension PRLoginManagerVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        vMenu.horizontalBarLeftAnchorConstraint?.constant = (scrollView.contentOffset.x + 40)/2
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        vMenu.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvContainMenu.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let controler = controllers[indexPath.item]
        addChildViewController(controler)
        controler.view.frame = cell.contentView.bounds
        cell.addSubview(controler.view)
        controler.view.fillSuperview()
        
        didMove(toParentViewController: controler)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cvContainMenu.frame.width,height: cvContainMenu.frame.height)
    }

}

extension PRLoginManagerVC: MenuBarDelegate {
    func itemMenuSelected(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        cvContainMenu.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}

