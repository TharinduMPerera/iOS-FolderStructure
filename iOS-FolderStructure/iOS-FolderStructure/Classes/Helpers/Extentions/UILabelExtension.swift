//
//  UILabelExtension.swift
//  iOS-FolderStructure
//
//  Created by Tharindu Perera on 2/22/19.
//  Copyright © 2019 Tharindu Perera. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setTitleAndValue(title: String, value: String) {
        let text = title + value
        
        let aString = NSMutableAttributedString(string: text)
        aString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18.0) as Any, range: (text as NSString).range(of: text))
        aString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: title))
        aString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: (text as NSString).range(of: value))
        
        attributedText = aString
    }
}
