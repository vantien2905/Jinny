//
//  PRPhotoDetail.swift
//  Prelens-jinny
//
//  Created by Lamp on 20/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage

class PRPhotoDetail: BaseViewController {
    
    @IBOutlet weak var cvPhotoPreview: UICollectionView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    var imgArray: Any? //[UIImage]()
    var photoData: [Image]?
    var passedContentOffset = IndexPath()
    
    private var currentPage: Int = 0 {
        didSet {
            guard let count = photoData?.count else { return }
            if currentPage > 0 && currentPage < count - 1 {
                btnBack.isHidden    = false
                btnNext.isHidden        = false
            } else if currentPage > 0 && currentPage == count - 1 {
                btnBack.isHidden    = false
                btnNext.isHidden        = true
            } else if currentPage == 0 && count > 1 {
                btnBack.isHidden    = true
                btnNext.isHidden        = false
            } else {
                btnBack.isHidden    = true
                btnNext.isHidden        = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configureCollectionView()
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = cvPhotoPreview.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.itemSize = cvPhotoPreview.frame.size
        flowLayout.invalidateLayout()
        cvPhotoPreview.collectionViewLayout.invalidateLayout()
    }
    
    func didMoveTo(page: Int) {
        guard let count = photoData?.count else { return }
        guard page >= 0 && page < count else { return }
        
        currentPage = page
        let targetOffsetX = cvPhotoPreview.frame.size.width * CGFloat(currentPage)
        cvPhotoPreview.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let offset = cvPhotoPreview.contentOffset
        let width  = cvPhotoPreview.bounds.size.width
        
        let index = round(offset.x / width)
        let newOffset = CGPoint(x: index * size.width, y: offset.y)

        cvPhotoPreview.setContentOffset(newOffset, animated: false)
       
        coordinator.animate(alongsideTransition: { (context) in
            self.cvPhotoPreview.reloadData()
            self.cvPhotoPreview.setContentOffset(newOffset, animated: false)
        }, completion: nil)
    }
    
    func setUpView() {
        setTitle(title: "", textColor: .black, backgroundColor: .black)
        self.view.backgroundColor = UIColor.black
        addWhiteBackButton()
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        layout.scrollDirection = .horizontal
        cvPhotoPreview.bounces = false
        cvPhotoPreview.collectionViewLayout = layout
        cvPhotoPreview.backgroundColor = .clear
        cvPhotoPreview.delegate = self
        cvPhotoPreview.dataSource = self
        cvPhotoPreview.register(ImagePreviewFullViewCell.self, forCellWithReuseIdentifier: "Cell")
        cvPhotoPreview.isPagingEnabled = true
        //  cvPhotoPreview.scrollToItem(at: passedContentOffset, at: .left, animated: true) //pass this from vc to goto the photo at indexpath
        
        cvPhotoPreview.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
    }
    
    @IBAction func btnNextTapped() {
        didMoveTo(page: currentPage + 1)
    }
    
    @IBAction func btnPreviousTapped() {
        didMoveTo(page: currentPage - 1)
    }
    
}

extension PRPhotoDetail: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberCells = photoData?.count else { return 0 }
        return numberCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagePreviewFullViewCell
        guard let data = photoData else { return UICollectionViewCell() }
        //cell.imgView.image=imgArray[indexPath.row]
        cell.imgView.sd_setImage(with: (data[indexPath.row].url?.original)!, placeholder: nil, failedImage: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: self.view.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = scrollView.currentPage - 1
        didMoveTo(page: currentPage)
    }
}

class ImagePreviewFullViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var scrollImg: UIScrollView!
    var imgView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 4.0
        
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)
        
        self.addSubview(scrollImg)
        
        imgView = UIImageView()
        scrollImg.addSubview(imgView!)
        imgView.contentMode = .scaleAspectFit
    }
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imvSize = imgView.bounds.size
        let scrollViewSize = scrollImg.bounds.size
        let verticalPadding = imvSize.height < scrollViewSize.height ? (scrollViewSize.height - imvSize.height) / 2 : 0
        let horizontalPadding = imvSize.width < scrollViewSize.width ? (scrollViewSize.width - imvSize.width) / 2 : 0
        
        scrollImg.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imgView.frame.size.height / scale
        zoomRect.size.width  = imgView.frame.size.width  / scale
        let newCenter = imgView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollImg.frame = self.bounds
        imgView.frame = self.bounds
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollImg.setZoomScale(1, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}