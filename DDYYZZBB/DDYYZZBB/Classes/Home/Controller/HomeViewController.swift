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

    //懒加载
    fileprivate lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleViewFream = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleViewFream, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        let contentFream = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: kScreenH-(kStatusBarH+kNavigationBarH+kTitleViewH+kTabbarH))
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let pageContentView = PageContentView(frame: contentFream, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    //系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
}

//ui界面的设置
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
        
        let historyItem = UIBarButtonItem.creatItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)
        
        let seacrchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
    
        let qrcodeItem = UIBarButtonItem.creatItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem,seacrchItem,qrcodeItem]
    
    }
}

//遵守协议 方法
extension HomeViewController : PageTitleViewDelegate {
    func PageTitleViewAndIndex(titleView: PageTitleView, slelectIndex index: Int) {
        self.pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentViewAndPST(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        self.pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
























































