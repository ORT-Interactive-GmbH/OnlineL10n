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

    func displayFlag(flag: NSData?) {
        if (flag == nil) {
            imageViewFlag.hidden = true
            constraintImageWidth.constant = 0.0
        } else {
            imageViewFlag.hidden = false
            constraintImageWidth.constant = 40.0
            imageViewFlag.image = UIImage(data: flag!)
        }
    }
}
