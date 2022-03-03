//
//  TaxiCollectionViewCell.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 02/03/2022.
//

import UIKit

class TaxiCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var labelTitle: UILabel!
    func configure(with name: String) {
        labelTitle.text = name
    }
}
