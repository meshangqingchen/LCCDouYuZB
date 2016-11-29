//
//  UIBarButtonItem-Extension.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/28.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    class func creatItem(imageName : String, hightImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 40, height: 40))
        return UIBarButtonItem(customView: btn);
    }
    
    //便利 函数
    convenience init(imageName : String,highImageName : String,size : CGSize) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
    
//        self.init(customView : btn)
        self.init(customView : btn)
        
    }
    
    
    
}













































































































