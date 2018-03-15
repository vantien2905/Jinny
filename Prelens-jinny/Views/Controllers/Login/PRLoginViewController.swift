//
//  PRLoginViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/10/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PRLoginViewController: UIViewController {

    @IBOutlet weak var vContainMenu: UIView!
    @IBOutlet weak var cvMenuController: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var currentIndex = 0 
    
    var controllers = [UIViewController]()
    var parentNavigationController  : UINavigationController?
    
    let vcSignIn = PRSignInViewController.initControllerFromNib() as! PRSignInViewController
    let vcSignUp = PRSignUpViewController.initControllerFromNib() as! PRSignUpViewController
    let cellId = "CellId"
    
    let vMenu:MenuView = {
        let view = MenuView()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        let listItemMenu = [
            MenuItem(title: "SIGN UP", isSelected: true),
            MenuItem(title: "SIGN IN", isSelected: false)
        ]
        controllers = [ vcSignUp, vcSignIn ]
        self.vMenu.setUpMenuView(menuColorBackground: .clear, listItem: listItemMenu)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView(){
        self.navigationController?.isNavigationBarHidden = true
        configMenuView()
        
    }
    private func configMenuView(){
        self.vContainMenu.addSubview(vMenu)
        vMenu.delegate = self
        vMenu.fillSuperview()
    }
    
    func configCollectionView(){
        cvMenuController.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cvMenuController.dataSource = self
        cvMenuController.delegate = self
        cvMenuController.isPagingEnabled = true
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        scrollView.contentSize.height = 600
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        scrollView.contentSize.height = 667
    }
    
}
extension PRLoginViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        return CGSize(width: view.frame.width,height: cvMenuController.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension PRLoginViewController: MenuBarDelegate {
    func itemMenuSelected(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        cvMenuController.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
