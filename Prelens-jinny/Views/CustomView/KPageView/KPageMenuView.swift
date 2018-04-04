//
//  KPageMenuView.swift
//  NCS
//
//  Created by Kai Pham on 11/21/17.
//  Copyright © 2017 sg.vinova.nsc. All rights reserved.
//

import UIKit

protocol KPageMenuViewDelegate: class {
    func itemMenuSelected(index: Int)
}

class KPageMenuView: UIView {
    let cvMenu: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    let vHorizotal: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    let vLineTop: UIView = {
        let view = UIView()
        view.backgroundColor = .gray //NCSColor.lineColor
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
    
    let cellId = "MenuSlideTopViewCell"
    
    var listItem = [AnyObject]() {
        didSet {
            cvMenu.reloadData()
            self.vHorizotal.backgroundColor = menuColorHorizontal
        }
    }
    
    //---
    var menuColorSelected: UIColor = UIColor.red
    var menuColorNormal: UIColor = UIColor.blue
    var menuFont: UIFont = UIFont.boldSystemFont(ofSize: 13)
    
    //--- horizontal
    var menuColorHorizontal: UIColor = UIColor.black
    var heightHorizontal: CGFloat = 10
    
    weak var delegate: KPageMenuViewDelegate?
    var isFullView: Bool = false
    
    func setUpView() {
        addSubview(cvMenu)
        addSubview(vLineTop)
        cvMenu.fillSuperview()
        cvMenu.addSubview(vHorizotal)
        
        vLineTop.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        //---
        configureCollection()
    }
    
    func setUpViewMenu(menuColorBackground: UIColor, menuFont: UIFont, menuColorNormal: UIColor, menuColorSelected: UIColor, menuColorHorizontal: UIColor, heightHorizontal: CGFloat, listItem: [KCategory], isFull: Bool = false, isHaveLineTop: Bool = false) {
        backgroundColor = menuColorBackground
        self.menuFont = menuFont
        self.menuColorSelected = menuColorSelected
        self.menuColorNormal = menuColorNormal
        self.heightHorizontal = heightHorizontal
        self.menuColorHorizontal = menuColorHorizontal
        self.isFullView = isFull
        self.vLineTop.isHidden = !isHaveLineTop
        
        self.listItem = listItem
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }
}

// MARK: handle Collection view
extension KPageMenuView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func configureCollection() {
        cvMenu.register(KPageMenuViewCell.self, forCellWithReuseIdentifier: cellId)
        cvMenu.delegate = self
        cvMenu.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! KPageMenuViewCell
        cell.setData(item: listItem[indexPath.item], font: menuFont, normalColor: menuColorNormal, selectedColor: menuColorSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isFullView {
            let wid = collectionView.frame.width /  CGFloat(listItem.count)
            if indexPath.item == 0 && vHorizotal.frame.width == 0 {
                vHorizotal.frame = CGRect(x: 0, y: cvMenu.frame.height - heightHorizontal, width: wid, height: heightHorizontal)
            }
            
            return CGSize(width: wid, height: collectionView.frame.height)
        } else {
            if let itemStr = listItem[indexPath.item] as? KCategory {
                let wid = estimateWidth(customFont: self.menuFont, str: itemStr.title) + 20
                if indexPath.item == 0 && vHorizotal.frame.width == 0 {
                    vHorizotal.frame = CGRect(x: 0, y: cvMenu.frame.height - heightHorizontal, width: wid, height: heightHorizontal)
                }
                return CGSize(width: wid, height: collectionView.frame.height)
            }
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func estimateWidth(customFont: UIFont, str: String) -> CGFloat {
        let size = CGSize(width: 1000, height: customFont.lineHeight)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: customFont], context: nil)
        
        return estimateFrame.width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToIndex(index: indexPath.item)
        delegate?.itemMenuSelected(index: indexPath.item)
    }
    
    // use when rotate device
    func setHorizontal(index: Int, isFullCell: Bool = true) {
        let widthCell = cvMenu.frame.width / CGFloat(listItem.count)
        let x = CGFloat(index) * widthCell
        if !isFullCell {
            self.vHorizotal.frame = CGRect(x: x, y: vHorizotal.frame.minY, width: vHorizotal.frame.width, height: vHorizotal.frame.height)
        } else {
            self.vHorizotal.frame = CGRect(x: x, y: vHorizotal.frame.minY, width: widthCell, height: vHorizotal.frame.height)
        }
        
    }
    
    func scrollToIndex(index: Int) {
        
        //get cell selected
        let indexPath = IndexPath(item: index, section: 0)
        guard let cellScroll = cvMenu.cellForItem(at: indexPath) as? KPageMenuViewCell else { return }
        
        UIView.animate(withDuration: 0.5) {
            //-- scroll view horizontal
            self.vHorizotal.frame = CGRect(x: self.vHorizotal.frame.minX, y: self.vHorizotal.frame.minY, width: cellScroll.frame.width, height: self.vHorizotal.frame.height)
            self.vHorizotal.center.x = cellScroll.center.x
            
            //-- scroll collction view
            self.cvMenu.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            //-- set color nomal for all item in screen
            //-- indexPathsForVisibleItems get indexPath all item in screen
            let listIndexPathVisible = self.cvMenu.indexPathsForVisibleItems
            for indexPath in listIndexPathVisible {
                if let cell = self.cvMenu.cellForItem(at: indexPath) as? KPageMenuViewCell {
                    cell.lbTitle.textColor = self.menuColorNormal
                }
            }
            
            //-- set color selected for current cell
            cellScroll.lbTitle.textColor = self.menuColorSelected
            
            //--
            guard let listCategory = self.listItem as? [KCategory] else { return }
            for i in 0...listCategory.count - 1 {
                listCategory[i].isSelected = false
            }
            listCategory[index].isSelected = true
        }
    }
}

// MARK: KPageMenuViewCell
class KPageMenuViewCell: UICollectionViewCell {
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.text = "Title Category"
        lb.textColor = UIColor.white
        lb.font =  UIFont.boldSystemFont(ofSize: 15)
//        lb.accessibilityFont()
        lb.textAlignment = .center
        
        return lb
    }()
    
    let vNotification: UIView = {
       let view = UIView()
        view.backgroundColor = .clear //NCSColor.brandColor
        
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
    
    func setData(item: AnyObject?, font: UIFont, normalColor: UIColor, selectedColor: UIColor) {
        if let cate = item as? KCategory {
            lbTitle.text = cate.title
            lbTitle.font = font
//            lbTitle.accessibilityFont()
            lbTitle.textColor = cate.isSelected == true ? selectedColor : normalColor
            
            if cate.title.isEmpty {
                vNotification.isHidden = true
            } else {
                vNotification.isHidden = cate.count == 0
            }
        }
    }
    
    func setUpView() {
        addSubview(lbTitle)
        lbTitle.centerSuperview()
        
        addSubview(vNotification)
        let width: CGFloat = 6
        vNotification.anchor(lbTitle.topAnchor, left: lbTitle.rightAnchor, topConstant: -3, leftConstant: 5, widthConstant: width, heightConstant: width)
        vNotification.setBorder(cornerRadius: width/2)
    }
}

class KCategory {
    var title: String = ""
    var isSelected: Bool = false
    var count: Int = 0
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
