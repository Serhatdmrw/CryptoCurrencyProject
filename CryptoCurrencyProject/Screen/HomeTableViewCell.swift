//
//  HomeTableViewCell.swift
//  CryptoCurrencyProject
//
//  Created by Serhat Demir on 27.03.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var cellSubView: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
