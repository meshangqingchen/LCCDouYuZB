//
//  HomeViewController.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/20.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {

    fileprivate lazy var pageTitleView : PageTitleView = {
        let titleViewFream = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleViewFream, titles: titles)
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {
        let contentFream = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: kScreenH-(kStatusBarH+kNavigationBarH+kTitleViewH+kTabbarH))
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let pageContentView = PageContentView(frame: contentFream, childVcs: childVcs, parentViewController: self)
        return pageContentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
}

extension HomeViewController {
    func setupUI() {
        //0不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //1设置导航栏
        setupNavigationBar()
        //2添加TitleView
        self.view.addSubview(self.pageTitleView)
        //3添加ContentView
        self.view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
        
    }
    
    private func setupNavigationBar() {
        let btn = UIButton()
        let img = UIImage(named: "logo")
        btn.setImage(img, for: .normal)
        btn.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        let size = CGSize(width: 40.0, height: 40)
//        let historyBtn = UIButton()//
//        historyBtn.frame = fream;
//        historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
//        historyBtn.setImage(UIImage(named: "Image_my_history_click"), for: .highlighted)
//        historyBtn.sizeToFit()
//        let historyItem = UIBarButtonItem(customView: historyBtn)
        let historyItem = UIBarButtonItem.creatItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)
        
       
        
//        let seacrchItem = UIBarButtonItem.creatItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        let seacrchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        
        
        
        
//        let qrcodeBtn = UIButton()
//        qrcodeBtn.frame = fream
//        qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
//        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
//        qrcodeBtn.sizeToFit()
//        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        
        let qrcodeItem = UIBarButtonItem.creatItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem,seacrchItem,qrcodeItem]
    
    }
}




























































