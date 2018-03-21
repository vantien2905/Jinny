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

protocol SearchMembershipCellDelegate: class {
    func searchTextChange(textSearch: String?)
}

class SearchMembershipCell: UICollectionViewCell {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var vSearch: UIView!
    let disposeBag = DisposeBag()
    weak var delegate: SearchMembershipCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }

    func setUpView() {
        tfSearch.borderStyle = .none
        tfSearch.attributedPlaceholder = "Search membership".toAttributedString(color: UIColor.black.withAlphaComponent(0.5), font: PRFont.regular15, isUnderLine: false)
        vSearch.layer.cornerRadius = 2.5
        vSearch.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        vSearch.setShadow(color: PRColor.lineColor, opacity: 1, offSet: CGSize(width: -1, height: 1.5), radius: 2.5, scale: true)
        
        tfSearch.rx.text.asObservable().subscribe( onNext: {[weak self](string: String?) in
                self?.delegate?.searchTextChange(textSearch: string)
        }).disposed(by: disposeBag)
        
    }

}
