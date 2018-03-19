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
    
    let vScrollBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    var titleFont: UIFont?
    
    var listItem = [AnyObject]() {
        didSet {
            collectionView.reloadData()
            setupScrollBar(item: CGFloat(listItem.count))
        }
    }
    
    weak var delegate: MenuBarDelegate?
    let cellID = "MenuBarCell"
    var horizontalBarLeftAnchorConstraint:NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implement")
    }
    
    func setupCollectionView(){
        collectionView.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.anchor(self.topAnchor, left: self.leftAnchor,bottom: self.bottomAnchor,right: self.rightAnchor, topConstant: 0, leftConstant: 0 ,bottomConstant:0 ,rightConstant:0)
    }
    
    func setupScrollBar(item: CGFloat){
        vScrollBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vScrollBar)
        horizontalBarLeftAnchorConstraint = vScrollBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        vScrollBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        vScrollBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/item).isActive = true
        vScrollBar.heightAnchor.constraint(equalToConstant: 4.0).isActive = true
    }
    
    func scrollToIndex(index: Int) {
        
        //get cell selected
        let indexPath = IndexPath(item: index, section: 0)
        guard let cellScroll = collectionView.cellForItem(at: indexPath) as? MenuItemCollectionViewCell else { return }
        
        UIView.animate(withDuration: 0.5) {
            //-- scroll view horizontal
            self.vScrollBar.frame = CGRect(x: self.vScrollBar.frame.minX, y: self.vScrollBar.frame.minY, width: cellScroll.frame.width, height: self.vScrollBar.frame.height)
            self.vScrollBar.center.x = cellScroll.center.x
            
            //-- scroll collction view
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            //-- set color nomal for all item in screen
            //-- indexPathsForVisibleItems get indexPath all item in screen
            let listIndexPathVisible = self.collectionView.indexPathsForVisibleItems
            for indexPath in listIndexPathVisible {
                if let cell = self.collectionView.cellForItem(at: indexPath) as? MenuItemCollectionViewCell {
                    cell.lbTitle.textColor = UIColor.lightGray
                }
            }
            
            //-- set color selected for current cell
            cellScroll.lbTitle.textColor = UIColor.black
            
            //--
            guard let listCategory = self.listItem as? [MenuItem] else { return }
            for i in 0...listCategory.count - 1 {
                listCategory[i].isSelected = false
            }
            listCategory[index].isSelected = true
        }
    }
    
    func setUpMenuView(menuColorBackground: UIColor, listItem: [MenuItem], textFont: UIFont?)
    {
        self.listItem = listItem
        self.titleFont = textFont
    }
}

extension MenuView:UICollectionViewDataSource,UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        as! MenuItemCollectionViewCell
        cell.setData(item: listItem[indexPath.item], normalColor: UIColor.lightGray, selectedColor: UIColor.black)
        cell.lbTitle.font = titleFont
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/CGFloat(listItem.count), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemMenuSelected(index: indexPath.item)
        scrollToIndex(index: indexPath.item)
    }
}

class MenuItemCollectionViewCell: UICollectionViewCell {
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.text = "SIGN UP"
        lb.textColor = UIColor.gray
        lb.font =  UIFont(name: "OstrichSans-Black", size: 17.5)
        lb.textAlignment = .center
        
        return lb
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
        }
    }
    
    func setUpView() {
        addSubview(lbTitle)
        lbTitle.centerXToSuperview()
        lbTitle.centerYToSuperview()
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


