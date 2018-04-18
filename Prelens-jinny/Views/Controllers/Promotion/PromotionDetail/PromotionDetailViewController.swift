//
//  PromotionDetailViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class PromotionDetailViewController: BaseViewController {
    
    @IBOutlet weak var cvVoucherDetail: UICollectionView!
    @IBOutlet weak var btnRedeem: UIButton!
    
    let disposeBag = DisposeBag()
    var voucherArchived: Bool? = false
    
    var merchantName: String?
    var cellSize: [CGSize]? = [CGSize]()
    
    var starTapped: Bool? {
        didSet {
            if let _starTapped = starTapped {
                _starTapped ? self.addStarButtonOn() : self.addStarButtonOff()
            }
        }
    }
    var viewModel: PromotionDetailViewModelProtocol!
    
    var promotionDetail:  PromotionDetail? {
        didSet {
            cvVoucherDetail.reloadData()
            getCellSize()
            // MARK: Setup the merchantName
            if let merchantName = promotionDetail?.merchantName {
                setNavigation(name: merchantName)
            } else {
                setNavigation(name: "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpComponents()
        
        guard let isArchived = voucherArchived  else { return }
        if isArchived {
            btnRedeem.backgroundColor = .gray
            btnRedeem.isEnabled = false
            addStarButtonDisabled()
            self.navigationController?.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            btnRedeem.backgroundColor =  PRColor.mainAppColor
            btnRedeem.isEnabled = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        darkStatus()
        bindData()
        
    }
    
    class func configureViewController(idVoucher: String) -> PromotionDetailViewController {
        let vcVoucherDetail = PromotionDetailViewController.initControllerFromNib() as! PromotionDetailViewController
        var viewModel: PromotionDetailViewModelProtocol {
            return PromotionDetailViewModel(id: idVoucher)
        }
        vcVoucherDetail.viewModel = viewModel
        return vcVoucherDetail
    }
    
    func getCellSize() {
        guard let data = self.promotionDetail else { return }
        guard let images = data.image else { return }
        for img in images {
            guard let _url = img.url?.original, let url = URL(string: _url) else { return }
            if let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil) {
                if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                    let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! CGFloat
                    let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! CGFloat
                    let imageWidth  = pixelWidth
                    let imageHeight = pixelHeight
                    let cellWidth   = UIScreen.main.bounds.width - 14
                    let cellHeight  = (cellWidth*imageHeight)/imageWidth
                    self.cellSize?.append(CGSize(width: cellWidth, height: cellHeight))
                }
            }
            
        }
    }
    
    func setUpComponents() {
        darkStatus()
        cvVoucherDetail.backgroundColor = PRColor.backgroundColor
        cvVoucherDetail.delegate = self
        cvVoucherDetail.dataSource = self
        
        cvVoucherDetail.register(UINib(nibName: Cell.promotionDetailCell, bundle: nil),
                                 forCellWithReuseIdentifier: "promotionDetailCell")
        cvVoucherDetail.register(UINib(nibName: Cell.promotionDetailHeaderCell, bundle: nil),
                                 forCellWithReuseIdentifier: "headerCell")
        cvVoucherDetail.register(UINib(nibName: Cell.promotionDetailFooterCell, bundle: nil),
                                 forCellWithReuseIdentifier: "footerCell")
    }
    
    func setNavigation(name: String) {
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: name, textColor: .black, backgroundColor: .white)
        addBackButton()
        addStarButtonOff()
        self.delegate = self
    }
    
    func bindData() {
        viewModel.voucherDetail.asObservable().subscribe(onNext: { [weak self] voucher in
            guard let strongSelf = self else { return }
            strongSelf.promotionDetail = voucher
            strongSelf.starTapped = voucher?.isBookmarked
            
        }).disposed(by: disposeBag)
        
        viewModel.isBookmarked.asObservable().subscribe(onNext: { [weak self] value in
            value ? self?.addStarButtonOn() : self?.addStarButtonOff()
        }).disposed(by: disposeBag)
    }
    
    @IBAction func redeemTapped() {
        let vc = RedeemVoucherViewController.instantiateFromNib()
        vc.promotionDetail = promotionDetail
        self.push(controller: vc)
    }
}

extension PromotionDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            guard let numberOfCells = promotionDetail?.image?.count else { return 0 }
            return numberOfCells
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell",
                                                                for: indexPath) as! PromotionDetailHeaderCell
            if let data = promotionDetail {
                headerCell.setUpView(with: data)
            }
            
            return headerCell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promotionDetailCell",
                                                          for: indexPath) as! PromotionDetailCell
            guard let data = promotionDetail, let listImage = data.image else { return UICollectionViewCell()}
            let image = listImage[indexPath.row]
            cell.setUpView(with: image)
            return cell
        } else {
            let footerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "footerCell",
                                                                for: indexPath) as! PromotionDetailFooterCell
            footerCell.btnRemoveDelegate = self
            return footerCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let height = promotionDetail?.detailDescription?.height(withConstrainedWidth: UIScreen.main.bounds.width - 2*7, font: UIFont(name: "SegoeUI-Semibold", size: 17)!)
            let size = UIScreen.main.bounds.width
            
            guard let _height = height else { return CGSize(width: size, height: 130 - (57) + 102) }
            return CGSize(width: size, height: 132 - (57 - _height) + 102)
        } else if indexPath.section == 1 {
            let size = UIScreen.main.bounds.width - 12
            guard let _cellSize = cellSize else { return CGSize(width: size, height: 0.75*size) }
            return _cellSize[indexPath.row]
        } else if indexPath.section == 2 {
            let size = UIScreen.main.bounds.width - 12
            
            return CGSize(width: size, height: 100)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 23, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = PRPhotoDetail()
            vc.photoData = promotionDetail?.image
            push(controller: vc, animated: true)
        }
    }
}

extension PromotionDetailViewController: BaseViewControllerDelegate {
    func starBookmarkTapped() {
        if let isArchived = voucherArchived {
            if !isArchived {
                if let _starTapped = starTapped {
                    starTapped = !_starTapped
                }
                guard let id = promotionDetail?.id else { return }
                viewModel.addBookmarkVoucher(idBookmark: id)
            } else {
            }
        }
    }
}

extension PromotionDetailViewController: PromotionDetailFooterCellDelegate {
    func btnRemoveTapped() {
        guard let id = promotionDetail?.id else { return }
        PopUpHelper.shared.showPopUpYesNo(message: "Remove this voucher?", actionYes: {
            self.viewModel.removeVoucher(idVoucher: id)
            PopUpHelper.shared.showPopUp(message: "Voucher removed", height: 120, action: {
                self.pop()
            })
        }, actionNo: {})
    }
}
