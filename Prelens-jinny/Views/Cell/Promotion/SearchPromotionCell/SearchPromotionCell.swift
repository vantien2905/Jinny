//
//  SearchMembershipCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchPromotionCellDelegate: class {
    func searchTextChange(textSearch: String?)
}

class SearchPromotionCell: UICollectionViewCell {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var vSearch: UIView!
    let disposeBag = DisposeBag()
    weak var delegate: SearchPromotionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpView() {
       tfSearch.borderStyle = .none
       tfSearch.attributedPlaceholder = "Search voucher".toAttributedString(color: UIColor.black.withAlphaComponent(0.5), font: PRFont.regular15, isUnderLine: false)
        vSearch.layer.cornerRadius = 2.5
        vSearch.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        vSearch.setShadow(color: PRColor.lineColor, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 2.5, scale: true)
        
        tfSearch.rx.text.asObservable().subscribe( onNext: {[weak self](string: String?) in
            guard let _string = string else { return }
           // if _string != "" {
                self?.delegate?.searchTextChange(textSearch: _string)
            //}
        }).disposed(by: disposeBag)
    }

}
