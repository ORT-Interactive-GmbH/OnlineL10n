//
//  CountryCell.swift
//  SwiftLocalization
//
//  Created by Sebastian Westemeyer on 28.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation

public let CountryCellStoryboardId = "CountryCell"

class CountryCell: UITableViewCell {
    @IBOutlet weak var imageViewFlag: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var constraintImageWidth: NSLayoutConstraint!

    func display(flag: Data?) {
        if (flag == nil) {
            imageViewFlag.isHidden = true
            constraintImageWidth.constant = 0.0
        } else {
            imageViewFlag.isHidden = false
            constraintImageWidth.constant = 40.0
            imageViewFlag.image = UIImage(data: flag!)
        }
    }
}
