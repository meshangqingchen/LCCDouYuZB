//
//  MainViewController.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/20.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       //1通过storyboard拿到我们的控制器
        addChiledVc(storyName: "home")
        addChiledVc(storyName: "live")
        addChiledVc(storyName: "follow")
        addChiledVc(storyName: "profile")
        
   }

    private func addChiledVc (storyName : String){
        //1通过storyboard拿到我们的控制器
        let chiledVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(chiledVC)
    }
}
