//
//  MenuBar.swift
//  Prelens-jinny
//
//  Created by vinova on 3/9/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
protocol MenuBarDelegate: class {
    func itemMenuSelected(index: Int)
}
class MenuView: UIView{
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let vHorizotal: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    var listItem = [AnyObject]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: MenuBarDelegate?
    let cellID = "MenuBarCell"
    var horizontalBarLeftAnchorConstraint:NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        
        collectionView.anchor(self.topAnchor, left: self.leftAnchor,bottom: self.bottomAnchor,right: self.rightAnchor, topConstant: 0, leftConstant: 0 ,bottomConstant:0 ,rightConstant:0)
        backgroundColor = UIColor.white
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
        setupHorizontalBar()
        
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implement")
    }
    
    func setupHorizontalBar(){
        let horizontalBarView = UIView()
        let width = collectionView.frame.width
        print(width)
        horizontalBarView.backgroundColor = UIColor.black
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20 )
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalToConstant: 335/2).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
    
    func setUpMenuView(menuColorBackground: UIColor, listItem: [MenuItem], isFull: Bool = false)
    {
        backgroundColor = menuColorBackground
        self.listItem = listItem
    }
}

extension MenuView:UICollectionViewDataSource,UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        as! MenuItemCollectionViewCell
        cell.setData(item: listItem[indexPath.item], normalColor: UIColor.lightGray, selectedColor: UIColor.black)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemMenuSelected(index: indexPath.item)
        let widthCell = collectionView.frame.width / 2
        let x = (CGFloat(indexPath.item) * widthCell)
        horizontalBarLeftAnchorConstraint?.constant = x
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1 , initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}

class MenuItemCollectionViewCell: UICollectionViewCell {
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.text = "SIGN UP"
        lb.textColor = UIColor.gray
        lb.font =  UIFont.boldSystemFont(ofSize: 20)
        lb.textAlignment = .center
        
        return lb
    }()
    
    let horizontalBarView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    override var isSelected: Bool {
        didSet{
            lbTitle.textColor = isSelected ? UIColor.black : UIColor.gray
            //horizontalBarView.backgroundColor = isSelected ? UIColor.black : UIColor.white
            
        }
    }
    
    func setUpView() {
        addSubview(lbTitle)
        lbTitle.centerXToSuperview()
        lbTitle.centerYToSuperview()
        addSubview(horizontalBarView)
        horizontalBarView.anchor(lbTitle.bottomAnchor, left: self.leftAnchor, topConstant: 8, leftConstant: 0, widthConstant: self.frame.width, heightConstant: 3)
        
    }
    
    func setData(item: AnyObject?, normalColor: UIColor, selectedColor: UIColor) {
        if let _item = item as? MenuItem {
            lbTitle.text = _item.title
            lbTitle.textColor = _item.isSelected == true ? selectedColor : normalColor
        }
    }
}
class MenuItem {
    var title: String = ""
    var isSelected: Bool = false
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}


