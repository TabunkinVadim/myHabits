//
//  UIViewExtension.swift
//  myHabits
//
//  Created by Табункин Вадим on 04.04.2022.
//

import UIKit

extension UIView {
    static var identifier:String {String(describing: self)}

    func  toAutoLayout () {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {addSubview($0)}
    }
}
