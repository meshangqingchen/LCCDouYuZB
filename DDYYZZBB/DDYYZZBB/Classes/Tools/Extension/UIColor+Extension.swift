//
//  UIColor+Extension.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/28.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat, g:CGFloat, b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
