//
//  UILabelExtension.swift
//  myHabits
//
//  Created by Табункин Вадим on 12.04.2022.
//

import UIKit

extension UILabel {
    func labelColorChange(For givenText: NSString,into color: UIColor, from locationNumber: Int, to length: Int){
        let myString:NSString = givenText
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "SFProText-Regular", size: 17)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: locationNumber,length: length))
        self.attributedText = myMutableString
    }
}
