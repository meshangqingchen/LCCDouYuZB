//
//  PageContentView.swift
//  DDYYZZBB
//
//  Created by 3D on 16/11/28.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit

class PageContentView: UIView {

    fileprivate var childVcs : [UIViewController]
    fileprivate var parentViewController : UIViewController
   
  
    
    //懒加载属性
    fileprivate lazy var collectionView : UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建UICollectionView
        let collectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    
    //构造函数
    init(frame: CGRect , childVcs: [UIViewController], parentViewController : UIViewController) {
        self.childVcs = childVcs;
        self.parentViewController = parentViewController;
        super.init(frame: frame)
        
        //设置ui
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView{
    fileprivate func setupUI(){
        //1将我们的自控制器添加到我们的父控制器中]
        for childVc in childVcs{
            parentViewController.addChildViewController(childVc)
        }
        //2添加UICollectionView,用于在cell中存放我们子控制器的View
        addSubview(self.collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView :UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.childVcs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        //给cell设置内容 之前移除以前添加的子视图
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let chidVc = self.childVcs[indexPath.row]
        chidVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(chidVc.view)
        return cell
    }
}






























