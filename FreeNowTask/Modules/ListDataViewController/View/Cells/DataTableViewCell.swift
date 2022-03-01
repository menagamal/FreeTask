//
//  DataTableViewCell.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    func configure(title: String, subTitle: String) {
        labelTitle.text = title
        labelSubTitle.text = subTitle
    }
}
