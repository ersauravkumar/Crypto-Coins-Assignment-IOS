//
//  UIView+Extension.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 04/11/24.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        String(String(describing: self))
    }
}
