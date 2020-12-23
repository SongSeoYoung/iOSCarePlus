//
//  IndicatorCell.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2020/12/23.
//

import UIKit

class IndicatorCell: UITableViewCell {

    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    func animationIndicatorView() {
        activityIndicatorView.startAnimating()
    }

}
