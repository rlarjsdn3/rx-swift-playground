//
//  UIColor+Ext.swift
//  HelloRxSwift
//
//  Created by 김건우 on 4/12/24.
//

import UIKit

extension UIColor {
    
    convenience init(red: Float, green: Float, blue: Float, alpha: CGFloat) {
        
        let normalizedRed = CGFloat(red) / 255
        let normalizedGreen = CGFloat(green) / 255
        let normalizedBlue = CGFloat(blue) / 255
        
        self.init(
            red: normalizedRed,
            green: normalizedGreen,
            blue: normalizedBlue,
            alpha: alpha
        )
        
    }
    
}
