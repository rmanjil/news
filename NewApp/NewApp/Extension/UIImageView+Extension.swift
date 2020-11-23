//
//  UIImageView+Extension.swift
//  NewApp
//
//  Created by manjil on 11/8/20.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(string: String) {
        if let url = URL(string: string) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url)
//            self.kf.setImage(with: url, completionHandler:
//                                { [weak self](_) in
//                                    self?.contentMode = .scaleAspectFill
//                                })

        }
    }
    
}
